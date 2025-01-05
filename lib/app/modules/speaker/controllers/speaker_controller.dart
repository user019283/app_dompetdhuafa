import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

class SpeakerController extends GetxController {
  //TODO: Implement SpeakerController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();

    _audioPlayer.onDurationChanged.listen((d) {
      duration.value = d;
    });

    _audioPlayer.onPositionChanged.listen((p) {
      position.value = p;
    });


  }

  @override
  void onReady() {
    super.onReady();
    // Mulai timer untuk memperbarui posisi setiap detik
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (isPlaying.value) {
        position.value = _audioPlayer.getCurrentPosition() as Duration; // Perbarui posisi
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    super.onClose();
  }

  final AudioPlayer _audioPlayer = AudioPlayer();

  var isPlaying = false.obs;
  var duration = Duration.zero.obs;
  var position = Duration.zero.obs;

  Timer? _timer;

  Future<void> playAudio(String url) async {
    await _audioPlayer.play(UrlSource(url));
    isPlaying.value = true; // Set isPlaying menjadi true ketika audio diputar
  }
// Fungsi untuk menjeda audio
  Future<void> pauseAudio() async {
    await _audioPlayer.pause();
    isPlaying.value = false; // Set isPlaying menjadi false ketika audio dijeda
  }
// Fungsi untuk melanjutkan pemutaran audio setelah dijeda
  Future<void> resumeAudio() async {
    await _audioPlayer.resume();
    isPlaying.value = true; // Set isPlaying menjadi true ketika audio dilanjutkan
  }
// Fungsi untuk menghentikan audio dan reset posisi ke awal
  Future<void> stopAudio() async {
    await _audioPlayer.stop();
    isPlaying.value = false; // Set isPlaying menjadi false ketika audio dihentikan
    position.value = Duration.zero; // Reset posisi ke awal
  }
// Fungsi untuk mengatur posisi audio (seek)
  void seekAudio(Duration newPosition) {
    _audioPlayer.seek(newPosition);
  }

}
