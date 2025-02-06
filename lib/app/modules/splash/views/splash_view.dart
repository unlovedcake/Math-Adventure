import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:math_adventure/app/modules/splash/controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController controller = Get.put(SplashController());

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            "assets/images/first_bg.png", // Replace with your image path
            fit: BoxFit.cover,
          ),

          // Linear Progress Indicator (Animated)
          Center(
            child: Obx(() => Container(
                  margin: EdgeInsets.only(top: 100),
                  width: 200,
                  child: LinearProgressIndicator(
                    value: controller.progressValue.value,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(10),
                    backgroundColor: Colors.white.withOpacity(0.5),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
