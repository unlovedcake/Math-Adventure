import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';
import 'package:math_adventure/app/modules/home/views/username_view.dart';
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
                onPressed: () {
                  Get.to(() => UserNameView());
                },
              ),
              _ButtonHomeWidget(
                label: 'INSTRUCTION',
                onPressed: () {
                  Get.toNamed(AppPages.INSTRUCTION);
                },
              ),
              _ButtonHomeWidget(
                label: 'SETTING',
                onPressed: () {
                  Get.toNamed(AppPages.SETTING);
                },
              ),
              _ButtonHomeWidget(
                label: 'ABOUT',
                onPressed: () {
                  Get.toNamed(AppPages.ADDITION);
                },
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
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
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
