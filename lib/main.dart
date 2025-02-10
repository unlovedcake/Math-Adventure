import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
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
