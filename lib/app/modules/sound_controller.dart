import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SoundController extends GetxController {
  final AudioPlayer _player = AudioPlayer();

  void playSound(String soundPath) async {
    try {
      await _player.play(AssetSource(soundPath), mode: PlayerMode.lowLatency);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void onClose() {
    _player.dispose();
    super.onClose();
  }
}
