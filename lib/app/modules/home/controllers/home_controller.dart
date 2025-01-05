import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_storage/get_storage.dart';

import 'package:dompetdhuafaconceptmodul4/app/modules/signin/controllers/signin_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/news_model.dart';

class HomeController extends GetxController {
  var isConnected = true.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SharedPreferences _preferences = Get.find<SharedPreferences>();
  final SigninController controller = Get.put(SigninController());
  final ImagePicker imagePicker = ImagePicker();
  final pickedImage = Rx<File?>(null);
  // static const String _category = 'business';
  RxList<Article> articles = RxList<Article>([]);
  RxBool isLoading = false.obs; // Observable boolean for loading state
  final box = GetStorage();
  @override
  onInit() async {
    super.onInit();
    fetchAvatar(); // Fetch avatar on initialization
    await fetchArticles();
    checkConnectivity();
  }

  void fetchAvatar() {
    String? avatarPath = box.read<String>('avatar');
    if (avatarPath != null) {
      pickedImage.value = File(avatarPath);
    }
  }

  Future<void> fetchArticles() async {
    try {
      isLoading.value = true;
      var response = await http.get(Uri.parse(
          "https://newsapi.org/v2/top-headlines?country=us&category=health&apiKey=9a9ae921f47740ed8d4d87452bf3018e"));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        NewsModel news = NewsModel.fromJson(jsonData);

        articles.assignAll(news.articles as Iterable<Article>);
      } else {
        throw Exception("error when request data");
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoading.value = false; // Set loading state to false when done
    }
  }

  Future<void> pickImage({required ImageSource source}) async {
    try {
      final pickedFile = await imagePicker.pickImage(source: source);
      if (pickedFile != null) {
        pickedImage.value = File(pickedFile.path);
        box.write('avatar', pickedFile.path); // Save avatar path
      }
    } catch (e) {
      print('Error while picking file: $e');
    }
  }

  void navigateToAvatarSettings() {
    Get.toNamed('/avatar-settings'); // Navigate to avatar settings page
  }

  Future<void> pickImageGalery() async {
    try {
      var pickedfile = await imagePicker.pickImage(source: ImageSource.gallery);

      //you can use ImageCourse.camera for Camera capture
      if (pickedfile != null) {
        pickedImage.value = File(pickedfile.path);
        // imagefiles.add(pickedImage.value!);
      }
    } catch (e) {
      print('error while picking file.');
    }
  }

  void logOut() {
    _preferences.remove('user_token');
    controller.isLogin.value = false;
    _auth.signOut();
    Get.snackbar('Log Out', 'Log Out Berhasil', backgroundColor: Colors.redAccent);
    Get.offAllNamed('/signin');
  }
  void checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    bool connected = connectivityResult != ConnectivityResult.none;
    isConnected.value = connected;

    // Menampilkan snackbar untuk status koneksi
    if (connected) {
      Get.snackbar('Koneksi Stabil', 'Anda terhubung ke internet', snackPosition: SnackPosition.TOP);
    } else {
      Get.snackbar('Koneksi Terputus', 'Tidak ada koneksi internet', snackPosition: SnackPosition.TOP, duration: Duration(seconds: 6));
    }
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    isConnected.value = result != ConnectivityResult.none;
  }
}
