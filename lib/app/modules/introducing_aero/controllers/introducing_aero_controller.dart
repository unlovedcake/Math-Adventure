import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:math_adventure/app/routes/app_pages.dart';

class IntroducingAeroController extends GetxController {
  var descriptions = [
    "Hi, I’m Aero! The astronaut. Would you help me to achieve my dream?!",
    "In the world where space exploration was a distant dream, there’s a young astronaut named Aero, who desires to touch the stars.",
    "However, the path to space is challenging, there are many obstacles that Aero needs to eliminate for his dreams to be real.",
    "To help Aero, you, a brilliant mathematician were recruited to assist him on his journey by solving math problems.",
  ].obs;

  final currentIndex = 0.obs;

  final AudioPlayer audioPlayerMusic = AudioPlayer();

  @override
  void onInit() {
    super.onInit();

    playMusic();
  }

  @override
  void onClose() {
    super.onClose();
    audioPlayerMusic.dispose();
  }

  void playMusic() async {
    try {
      await audioPlayerMusic.play(
        AssetSource('audio/music_math_adventure.mp3'),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void nextDescription() {
    if (currentIndex.value < descriptions.length - 1) {
      currentIndex.value++;
    } else {
      Get.offAllNamed(AppPages.INITIAL);
    }
  }

  String get buttonText =>
      currentIndex.value == descriptions.length - 1 ? "Proceed" : "Next";
}
