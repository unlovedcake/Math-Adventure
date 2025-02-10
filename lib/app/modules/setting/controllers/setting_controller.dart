import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:math_adventure/app/data/model/constants/global_variable.dart';
import 'package:math_adventure/app/modules/addition/controllers/addition_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingController extends GetxController {
  final isMusicOn = false.obs;
  final isSoundOn = false.obs;

  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void onInit() {
    // // TODO: implement onInit
    // super.onInit();
    // audioPlayer.onPositionChanged
    //     .listen((Duration p) => {print('Current position: $p')});
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isMusicOn', isMusicOn.value);
      // if (isMusicOn.value) {
      //   // Play audio when turned ON
      //   await audioPlayer.play(AssetSource('audio/music_add.mp3'),
      //       mode: PlayerMode.mediaPlayer);
      // } else {
      //   // Stop audio when turned OFF
      //   await audioPlayer.stop();

      //   print('STOP');
      // }
      isMusicIsOn.value = isMusicOn.value;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getMusicOn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? savedValue = prefs.getBool('isMusicOn');
    isMusicOn.value = savedValue ?? false;

    isMusicIsOn.value = isMusicOn.value;
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isSoundOn', isSoundOn.value);

      isSoundIsOn.value = isSoundOn.value;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
