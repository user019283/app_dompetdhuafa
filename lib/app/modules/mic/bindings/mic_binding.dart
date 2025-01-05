import 'package:get/get.dart';

import '../controllers/mic_controller.dart';

class MicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MicController>(
      () => MicController(),
    );
  }
}
