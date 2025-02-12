import 'package:get/get.dart';
import 'package:math_adventure/app/modules/sound_controller.dart';
import 'package:math_adventure/app/routes/app_pages.dart';

class SelectOperationController extends GetxController {
  final List<Map<String, dynamic>> operators = [
    {"image": "assets/images/add.png", "route": AppPages.ADDITION},
    {"image": "assets/images/minus.png", "route": AppPages.MINUS},
    {"image": "assets/images/times.png", "route": AppPages.MULTIPLICATION},
    {"image": "assets/images/divide.png", "route": AppPages.DIVISION},
    {"image": "assets/images/question_mark.png", "route": AppPages.ADDITION},
  ].obs;

  final soundController = Get.find<SoundController>();

  void navigateTo(String route) {
    soundController.playSound('audio/sound_laser.wav');
    Get.toNamed(route);
  }
}
