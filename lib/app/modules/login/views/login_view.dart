import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:math_adventure/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // No shadow
        leading: CircleAvatar(
          backgroundColor: Color(0xFFb6d5f0).withValues(alpha: 0.5),
          radius: 20,
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/username_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
              ),
              SizedBox(
                child: TextFormField(
                    style: TextStyle(color: Colors.white, fontSize: 22),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: "Enter User Name",
                      filled: true,
                      fillColor: Colors.grey.withValues(alpha: 0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          Get.toNamed(AppPages.INTRODUCINGAERO);
                        },
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 30,
                        ),
                      ), // Suffix icon
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
