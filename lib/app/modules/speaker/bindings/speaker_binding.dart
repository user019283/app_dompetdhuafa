import 'package:get/get.dart';

import '../controllers/speaker_controller.dart';

class SpeakerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpeakerController>(
      () => SpeakerController(),
    );
  }
}
