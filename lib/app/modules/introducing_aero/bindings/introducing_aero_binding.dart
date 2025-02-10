import 'package:get/get.dart';

import '../controllers/introducing_aero_controller.dart';

class IntroducingAeroBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IntroducingAeroController>(
      () => IntroducingAeroController(),
    );
  }
}
