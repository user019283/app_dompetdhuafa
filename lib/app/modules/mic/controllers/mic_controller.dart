import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class MicController extends GetxController {
  final stt.SpeechToText _speech = stt.SpeechToText();
  var isListening = false.obs;
  var text = "".obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    _initSpeech();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void _initSpeech() async {
    try {
      await _speech.initialize();
    } catch (e) {
      print(e);
    }
  }

  Future<void> checkMicrophonePermission() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      await Permission.microphone.request();
    }
  }

  void startListening() async {
    await checkMicrophonePermission();
    if (await Permission.microphone.isGranted) {
      isListening.value = true;
      await _speech.listen(onResult: (result) {
// Memperbarui kata-kata yang dikenali ke dalam variabel teks
        text.value = result.recognizedWords;
        print(result.recognizedWords);
      });
    } else {
      print("Izin mikrofon ditolak.");
    }
  }
// Menghentikan proses pengenalan suara
  void stopListening() async {
    isListening.value = false;
    await _speech.stop();
  }



}
