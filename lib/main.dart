import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:math_adventure/app/modules/sound_controller.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  Get.put(SoundController());
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "FLY ME TO THE SPACE THE MATH ADVENTURE",
      initialRoute: AppPages.SPLASH,
      getPages: AppPages.routes,
    ),
  );
}
