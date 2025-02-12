import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:math_adventure/app/modules/sound_controller.dart';
import 'package:math_adventure/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home_bg.png'),
            fit: BoxFit.cover, // This makes the image cover the entire screen
          ),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              Text(
                'WELCOME TO THE ADVENTURE!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              _ButtonHomeWidget(
                label: 'ENTER',
              ),
              _ButtonHomeWidget(
                label: 'INSTRUCTION',
              ),
              _ButtonHomeWidget(
                label: 'SETTING',
              ),
              _ButtonHomeWidget(
                label: 'ABOUT',
              ),
            ]
            // .animate(
            //   effects: [
            //     const FadeEffect(),
            //     const ScaleEffect(),
            //   ],
            //   interval: 600.ms,
            // ).fade(
            //   duration: 600.ms,
            // ),
            ),
      ),
    );
  }
}

class _ButtonHomeWidget extends StatelessWidget {
  const _ButtonHomeWidget({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    final soundController = Get.find<SoundController>();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          soundController.playSound('audio/sound_laser.wav');
          switch (label) {
            case 'ENTER':
              Get.toNamed(AppPages.SELECTOPERATION);
              break;
            case 'INSTRUCTION':
              Get.toNamed(AppPages.INSTRUCTION);
              break;
            case 'SETTING':
              Get.toNamed(AppPages.SETTING);
              break;
            case 'ABOUT':
              Get.toNamed(AppPages.ABOUT);
              break;
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF030f32), // Background color of the button
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Border radius of 10
            side: BorderSide(
              color: Colors.orange, // Border color orange
              width: 2, // Border width
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 22), // Text color
        ),
      ),
    );
  }
}
