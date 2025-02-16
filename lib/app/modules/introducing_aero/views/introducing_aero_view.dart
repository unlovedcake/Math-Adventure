import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/introducing_aero_controller.dart';

class IntroducingAeroView extends GetView<IntroducingAeroController> {
  const IntroducingAeroView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(IntroducingAeroController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('IntroducingAeroView'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/app_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/aero.png'),
              SizedBox(height: 20),

              // 🔹 Description Box with AnimatedSwitcher
              Obx(
                () => AnimatedSwitcher(
                  duration: Duration(seconds: 1),
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    key: ValueKey(controller.currentIndex.value),
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          controller
                              .descriptions[controller.currentIndex.value],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),

                        // 🔹 Next Button at Bottom Right
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: controller.nextDescription,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFb6d5f0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(controller.buttonText),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
