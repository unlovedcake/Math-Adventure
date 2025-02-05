import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:math_adventure/app/modules/addition/controllers/addition_controller.dart';
import 'package:math_adventure/app/modules/addition/views/addition_view.dart';
import 'package:math_adventure/app/routes/app_pages.dart';

import '../controllers/map_level_controller.dart';

class MapLevelView extends GetView<MapLevelController> {
  const MapLevelView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MapLevelController>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent AppBar
        elevation: 0, // No shadow
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/map_level.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          _ButtonLevel(
            x: 0,
            y: 450,
          ),
          _ButtonLevel(
            x: -20,
            y: 380,
          ),
          _ButtonLevel(
            x: 45,
            y: 320,
          ),
          _ButtonLevel(
            x: 125,
            y: 270,
          ),
          _ButtonLevel(
            x: 60,
            y: 220,
          ),
          _ButtonLevel(
            x: -40,
            y: 180,
          ),
          _ButtonLevel(
            x: 10,
            y: 260,
            w: 300,
            h: 300,
          ),
          _ButtonLevel(
            x: 90,
            y: 220,
            w: 250,
            h: 250,
          ),
          _ButtonLevel(
            x: 90,
            y: 220,
            w: 250,
            h: 250,
          ),
        ],
      ),
    );
  }
}

class _ButtonLevel extends StatelessWidget {
  _ButtonLevel({
    required this.x,
    required this.y,
    this.w,
    this.h,
  });

  final double x;
  final double y;
  double? w = 1000;
  double? h = 1000;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MapLevelController>();

    final addController = controller.additionController();

    print('adada ${addController?.level.value}');

    return Transform.translate(
      offset: Offset(x, y),
      child: GestureDetector(
        onTap: () {
          Get.to(() => AdditionView(),
              fullscreenDialog: true, preventDuplicates: false);
        },
        child: Container(
          width: w,
          height: h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/active_level.png',
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                addController?.level.value == 2
                    ? Colors.yellow
                    : Colors.grey.withOpacity(0.5), // Change color and opacity
                BlendMode.srcATop, // Apply blending mode
              ),
            ),
          ),
        ),
      ),
    );
  }
}
