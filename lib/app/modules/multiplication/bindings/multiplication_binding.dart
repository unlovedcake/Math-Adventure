import 'package:get/get.dart';

import '../controllers/multiplication_controller.dart';

class MultiplicationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MultiplicationController>(
      () => MultiplicationController(),
    );
  }
}
