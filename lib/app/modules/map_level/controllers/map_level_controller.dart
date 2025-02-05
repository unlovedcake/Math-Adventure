import 'package:get/get.dart';
import 'package:math_adventure/app/modules/addition/controllers/addition_controller.dart';

class MapLevelController extends GetxController {
  final count = 0.obs;

  final RxInt level = 1.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  AdditionController? additionController() {
    if (Get.isRegistered<AdditionController>()) {
      return Get.find<AdditionController>();
    } else {
      return null;
    }
  }
}
