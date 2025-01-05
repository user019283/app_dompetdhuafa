import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MapsController extends GetxController {
  Position? _currentPosition;
  String _locationMessage = "Mencari Lintang dan Bujur..."; // Changed here
  bool _loading = false;

  // Observable variables to update the UI
  var currentPosition = Rx<Position?>(null);
  var locationMessage = "Mencari Lintang dan Bujur...".obs; // Changed here
  var loading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Function to get the current location
  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    loading.value = true;  // Update loading status to true

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        throw Exception('Location service not enabled');
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permission denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permission denied forever');
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      // Update the observable values
      currentPosition.value = position;
      locationMessage.value = "Lintang: ${position.latitude}, Bujur: ${position.longitude}"; // Changed here
      loading.value = false;  // Set loading to false
    } catch (e) {
      // In case of an error, update the loading status and message
      loading.value = false;
      locationMessage.value = 'Gagal mendapatkan lokasi';
    }
  }

  // Updated method to launch URL using launchUrl and canLaunchUrl
  void _launchURL(String url) async {
    Uri uri = Uri.parse(url);  // Convert the string URL to a Uri

    if (await canLaunchUrl(uri)) {
      print(url);
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Open Google Maps with current position
  void openGoogleMaps() {
    print(currentPosition.value);

    // Ensure currentPosition is not null
    if (currentPosition.value != null) {
      final position = currentPosition.value!;
      final url =
          'https://www.google.com/maps?q=${position.latitude},${position.longitude}';
      print(url);
      _launchURL(url);
    } else {
      // Handle case where position is not available
      print("Current position is null.");
    }
  }
}
