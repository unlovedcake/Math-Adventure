import 'package:get/get.dart';

import '../controllers/minus_controller.dart';

class MinusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MinusController>(
      () => MinusController(),
    );
  }
}
