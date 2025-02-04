import 'package:get/get.dart';

import '../controllers/addition_controller.dart';

class AdditionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdditionController>(
      () => AdditionController(),
    );
  }
}
