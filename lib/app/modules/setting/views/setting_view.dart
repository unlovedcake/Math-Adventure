import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:math_adventure/app/modules/addition/controllers/addition_controller.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'SettingView',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: CircleAvatar(
          backgroundColor: Color(0xFFb6d5f0),
          radius: 20,
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              if (Get.isRegistered<AdditionController>()) {
                final addController = Get.put(AdditionController());
                addController.startTimer();
                addController.playMusic();

                print('OIS');
              }
              Get.back();
            },
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/app_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 🔹 Settings Icon (Top Center)
                  Icon(
                    Icons.settings,
                    size: 40,
                    color: Colors.white,
                  ),

                  SizedBox(height: 20),

                  // 🔹 Music Toggle Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Row(
                            children: [
                              Icon(
                                Icons.music_note,
                                color: controller.isMusicOn.value
                                    ? Colors.blue
                                    : Colors.white,
                                size: 50,
                              ),
                              SizedBox(width: 10),
                              Text("MUSIC",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Color(0xFFb6d5f0),
                                  )),
                            ],
                          )),
                      Obx(
                        () => Switch(
                          value: controller.isMusicOn.value,
                          onChanged: (value) => controller.toggleMusic(),
                          activeColor: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // 🔹 Music Toggle Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Row(
                            children: [
                              Icon(
                                controller.isSoundOn.value
                                    ? Icons.volume_down_outlined
                                    : Icons.volume_off,
                                color: controller.isSoundOn.value
                                    ? Colors.blue
                                    : Colors.white,
                                size: 50,
                              ),
                              SizedBox(width: 10),
                              Text("Sound",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Color(0xFFb6d5f0),
                                  )),
                            ],
                          )),
                      Obx(
                        () => Switch(
                          value: controller.isSoundOn.value,
                          onChanged: (value) => controller.toggleSound(),
                          activeColor: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // 🔹 Exit Button
                  GestureDetector(
                    onTap: () => Get.snackbar("Exit", "You clicked Exit"),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.white,
                          size: 50,
                        ),
                        SizedBox(width: 10),
                        Text("EXIT",
                            style: TextStyle(
                                fontSize: 18, color: Colors.redAccent)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
