import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:math_adventure/app/modules/login/views/login_view.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    return Scaffold(
      body: Stack(
        children: [
          // LiquidSwipe with images
          LiquidSwipe(
            pages: controller.images
                .map((image) => ImagePage(imagePath: image))
                .toList(),

            liquidController: controller.liquidController,
            fullTransitionValue: 700,
            enableLoop: false, // Disable loop to allow skip
            waveType: WaveType.liquidReveal,
            positionSlideIcon: 0.8,
            slideIconWidget: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPageChangeCallback: (pageIndex) {
              controller.updateIndex(pageIndex); // Update page index
            },
          ),
          // Dots indicator
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Obx(() {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    controller.images.length,
                    (index) => AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      width: controller.currentIndex.value == index ? 20 : 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: controller.currentIndex.value == index
                            ? Colors.blue
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          Positioned(
            bottom: 50,
            left: 100,
            child: ElevatedButton(
              onPressed: controller.previousPage,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
              ),
              child: Text("Previous"),
            ),
          ),

          Positioned(
            bottom: 50,
            left: 20,
            child: ElevatedButton(
              onPressed: controller.nextPage,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
              ),
              child: Text("Next"),
            ),
          ),

          // Get Started Button (Only on Last Page)
          Obx(() {
            return controller.currentIndex.value != controller.images.length - 1
                ? Positioned(
                    bottom: 50,
                    right: 20,
                    child: ElevatedButton(
                      onPressed: controller.skipToLast,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                      ),
                      child: Text("Skip"),
                    ),
                  )
                : Positioned(
                    bottom: 50,
                    right: 20,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => LoginView());
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                      ),
                      child: Text("Get Started"),
                    ),
                  );
          }),
        ],
      ),
    );
  }
}

class ImagePage extends StatelessWidget {
  final String imagePath;

  const ImagePage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
