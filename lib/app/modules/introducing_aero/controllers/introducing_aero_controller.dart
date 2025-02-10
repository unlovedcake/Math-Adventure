import 'package:get/get.dart';
import 'package:math_adventure/app/routes/app_pages.dart';

class IntroducingAeroController extends GetxController {
  var descriptions = [
    "Hi, I’m Aero! The astronaut. Would you help me to achieve my dream?!",
    "In the world where space exploration was a distant dream, there’s a young astronaut named Aero, who desires to touch the stars.",
    "However, the path to space is challenging, there are many obstacles that Aero needs to eliminate for his dreams to be real.",
    "To help Aero, you, a brilliant mathematician were recruited to assist him on his journey by solving math problems.",
  ].obs;

  var currentIndex = 0.obs;

  void nextDescription() {
    if (currentIndex.value < descriptions.length - 1) {
      currentIndex.value++;
    } else {
      Get.offAllNamed(AppPages.INITIAL);
    }
  }

  String get buttonText =>
      currentIndex.value == descriptions.length - 1 ? "Proceed" : "Next";
}
