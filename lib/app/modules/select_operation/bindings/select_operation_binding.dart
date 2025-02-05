import 'package:get/get.dart';

import '../controllers/select_operation_controller.dart';

class SelectOperationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectOperationController>(
      () => SelectOperationController(),
    );
  }
}
