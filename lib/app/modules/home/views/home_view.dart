import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:math_adventure/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
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
            _ButtonHomeWidget(
              label: 'Enter',
              onPressed: () {
                Get.toNamed(AppPages.ADDITION);
              },
            ),
            _ButtonHomeWidget(
              label: 'Instruction',
              onPressed: () {
                Get.toNamed(AppPages.ADDITION);
              },
            ),
            _ButtonHomeWidget(
              label: 'Setting',
              onPressed: () {
                Get.toNamed(AppPages.ADDITION);
              },
            ),
            _ButtonHomeWidget(
              label: 'About',
              onPressed: () {
                Get.toNamed(AppPages.ADDITION);
              },
            ),
          ],
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
