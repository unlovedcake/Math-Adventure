import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:math_adventure/app/data/model/constants/global_variable.dart';
import 'package:math_adventure/app/modules/sound_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingController extends GetxController {
  final isMusicOn = false.obs;
  final isSoundOn = false.obs;

  final AudioPlayer audioPlayer = AudioPlayer();

  final soundController = Get.find<SoundController>();

  @override
  void onInit() {
    super.onInit();
    getMusicOn();
    getSoundOn();
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }

  void toggleMusic() async {
    isMusicOn.value = !isMusicOn.value;

    try {
      soundController.playSound('audio/setting_sound.wav');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isMusicOn', isMusicOn.value);

      isMusicIsOn.value = isMusicOn.value;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getMusicOn() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? savedValue = prefs.getBool('isMusicOn');
      isMusicOn.value = savedValue ?? false;

      isMusicIsOn.value = isMusicOn.value;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getSoundOn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? savedValue = prefs.getBool('isSoundOn');
    isSoundOn.value = savedValue ?? false;

    isSoundIsOn.value = isSoundOn.value;
  }

  void toggleSound() async {
    isSoundOn.value = !isSoundOn.value;
    try {
      soundController.playSound('audio/setting_sound.wav');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isSoundOn', isSoundOn.value);

      isSoundIsOn.value = isSoundOn.value;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Rounded corners
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [Colors.blue.shade600, Colors.blue.shade300],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.exit_to_app, size: 50, color: Colors.white),
                const SizedBox(height: 10),
                Text(
                  "Exit App",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Are you sure you want to exit?",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (GetPlatform.isAndroid) {
                          SystemNavigator.pop(); // Close app on Android
                        } else {
                          Get.back();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Exit"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
