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
          Image.asset(
            "assets/images/splash_bg.png",
            fit: BoxFit.cover,
          ),

          // Linear Progress Indicator (Animated)
          Center(
            child: Obx(() => Container(
                  margin: EdgeInsets.only(top: 200),
                  width: 200,
                  child: LinearProgressIndicator(
                    value: controller.progressValue.value,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(10),
                    backgroundColor: Colors.white.withValues(alpha: 0.5),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
