import 'package:get/get.dart';
import 'package:math_adventure/app/routes/app_pages.dart';

class SelectOperationController extends GetxController {
  //TODO: Implement SelectOperationController

  final List<Map<String, dynamic>> operators = [
    {"image": "assets/images/add.png", "route": AppPages.ADDITION},
    {"image": "assets/images/minus.png", "route": AppPages.ADDITION},
    {"image": "assets/images/times.png", "route": AppPages.ADDITION},
    {"image": "assets/images/divide.png", "route": AppPages.ADDITION},
    {"image": "assets/images/question_mark.png", "route": AppPages.ADDITION},
  ].obs;

  void navigateTo(String route) {
    Get.toNamed(route);
  }

  final count = 0.obs;
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

  void increment() => count.value++;
}
