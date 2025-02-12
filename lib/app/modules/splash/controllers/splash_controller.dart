import 'dart:async';

import 'package:get/get.dart';
import 'package:math_adventure/app/routes/app_pages.dart';

class SplashController extends GetxController {
  var progressValue = 0.0.obs;
  var totalTime = 5; // 3 minutes in seconds
  var elapsedTime = 0.obs;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      elapsedTime.value++;
      progressValue.value = elapsedTime.value / totalTime;

      if (elapsedTime.value >= totalTime) {
        timer.cancel();
        Get.toNamed(AppPages.ONBOARDING); // Navigate to Home Page
      }
    });
  }
}
