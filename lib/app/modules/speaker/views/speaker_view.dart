import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/speaker_controller.dart';

class SpeakerView extends GetView<SpeakerController> {
  const SpeakerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const audioUrl = 'https://hhk.awamedia.store/uploads/new/music/2024/09/Drake-Rich-Baby-Daddy-ft-Sexyy-Red-SZA-(HipHopKit.com).mp3';
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpeakerView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Obx(() {
              return Slider(
                min: 0.0,
                  max: controller.duration.value.inSeconds.toDouble(),
                  value: controller.duration.value.inSeconds.toDouble(),
              onChanged: (value) {
              controller.seekAudio(Duration(seconds: value.toInt()));
              },
              );
            }),
            Obx(() {
              return Text(
                  '${_formatDuration(controller.position.value)} / ${_formatDuration(controller.duration.value)}',
              );
            }),
            const SizedBox(height: 20),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: controller.isPlaying.value
                        ? controller.pauseAudio
                        : controller.resumeAudio,
                    child: Text(controller.isPlaying.value ? 'Pause' :
                    'Resume'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => controller.playAudio(audioUrl),
                    child: const Text('Play'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: controller.stopAudio,
                    child: const Text('Stop'),
                  ),
                ],
              );
            }),

          ],
        ),
      )
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigitMinutes}:${twoDigitSeconds}';
  }
}
