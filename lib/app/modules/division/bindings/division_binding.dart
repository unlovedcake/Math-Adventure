import 'package:get/get.dart';

import '../controllers/division_controller.dart';

class DivisionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DivisionController>(
      () => DivisionController(),
    );
  }
}
