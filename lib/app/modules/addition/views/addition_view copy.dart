import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:math_adventure/app/modules/addition/controllers/addition_controller.dart';
import 'package:math_adventure/app/modules/addition/views/addition_view.dart';
import 'package:math_adventure/app/modules/addition/views/quiz_addition_view.dart';
import 'package:math_adventure/app/routes/app_pages.dart';

class AdditionView extends GetView<AdditionController> {
  const AdditionView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdditionController());
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenAspectRatio = screenWidth / screenHeight;
    print('HOYs ${controller.scoreSet}');
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent AppBar
        elevation: 0, // No shadow
        leading: CircleAvatar(
          backgroundColor: Color(0xFFb6d5f0),
          radius: 20,
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Image.asset(
          //   'assets/images/map_level.png',
          //   fit: BoxFit.cover,
          //   width: screenWidth,
          // ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/map_level.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Positioned.fill(
          //   child: Image.asset(
          //     'assets/images/map_level.png',
          //     fit: BoxFit.cover, // Ensures the image covers the screen
          //   ),
          // ),
          // // Overlay Images
          Positioned(
            bottom: 50,
            child: Stack(
              children: [
                _ButtonLevels(
                  level: 1,
                  w: 70,
                  h: 50,
                ),
                StarLevelWidget(index: 0, level: 1, controller: controller),
              ],
            ),
          ),
          Positioned(
            left: 140,
            bottom: 130,
            child: Stack(
              children: [
                _ButtonLevels(
                  level: 2,
                  w: 70,
                  h: 50,
                ),
                StarLevelWidget(index: 1, level: 2, controller: controller),
              ],
            ),
          ),
          Positioned(
            right: 90,
            bottom: 180,
            child: _ButtonLevels(
              level: 3,
              w: 70,
              h: 50,
            ),
          ),
          Positioned(
            right: 50,
            bottom: 230,
            child: _ButtonLevels(
              level: 4,
              w: 70,
              h: 50,
            ),
          ),
          Positioned(
            right: 120,
            bottom: 280,
            child: _ButtonLevels(
              level: 5,
              w: 70,
              h: 50,
            ),
          ),
          Positioned(
            left: 90,
            bottom: 330,
            child: _ButtonLevels(
              level: 6,
              w: 60,
              h: 40,
            ),
          ),

          Positioned(
            left: 90,
            bottom: 390,
            child: _ButtonLevels(
              level: 7,
              w: 50,
              h: 30,
            ),
          ),

          Positioned(
            bottom: 420,
            child: _ButtonLevels(
              level: 8,
              w: 50,
              h: 30,
            ),
          ),
          Positioned(
            left: 160,
            bottom: 460,
            child: _ButtonLevels(
              level: 9,
              w: 40,
              h: 30,
            ),
          ),
          Positioned(
            left: 60,
            bottom: 470,
            child: _ButtonLevels(
              level: 10,
              w: 40,
              h: 30,
            ),
          ),
          // Positioned(
          //   right: screenWidth * 0.2,
          //   top: screenHeight * 0.3,
          //   child: Image.asset('assets/images/active_level.png'),
          // ),
          // Positioned(
          //   left: screenWidth * 0.3,
          //   bottom: screenHeight * 0.2,
          //   child: Image.asset('assets/images/active_level.png'),
          // ),
          // Positioned(
          //   right: screenWidth * 0.15,
          //   bottom: screenHeight * 0.25,
          //   child: Image.asset('assets/images/active_level.png'),
          // ),
          // Positioned(
          //   left: screenWidth * 0.5 - 40, // Center horizontally
          //   top: screenHeight * 0.5 - 40, // Center vertically
          //   child: Image.asset('assets/images/active_level.png'),
          // ),
          // _ButtonLevel(
          //   x: 0,
          //   y: 450,
          //   level: 1,
          // ),
          // _ButtonLevel(
          //   x: -35,
          //   y: 380,
          //   level: 2,
          // ),
          // _ButtonLevel(
          //   x: 45,
          //   y: 320,
          //   level: 3,
          // ),
          // _ButtonLevel(
          //   x: 125,
          //   y: 270,
          //   level: 4,
          // ),
          // _ButtonLevel(
          //   x: 60,
          //   y: 220,
          //   level: 5,
          // ),
          // _ButtonLevel(
          //   x: -40,
          //   y: 180,
          //   level: 6,
          // ),
          // _ButtonLevel(
          //   x: 10,
          //   y: 260,
          //   w: 300,
          //   h: 300,
          //   level: 7,
          // ),
          // _ButtonLevel(
          //   x: 90,
          //   y: 240,
          //   w: 250,
          //   h: 250,
          //   level: 8,
          // ),
          // _ButtonLevel(
          //   x: 40,
          //   y: 200,
          //   w: 250,
          //   h: 250,
          //   level: 9,
          // ),
          // _ButtonLevel(
          //   x: -40,
          //   y: 190,
          //   w: 250,
          //   h: 250,
          //   level: 10,
          // ),
        ],
      ),
    );
  }
}

class StarLevelWidget extends StatelessWidget {
  const StarLevelWidget(
      {super.key,
      required this.controller,
      required this.index,
      required this.level});

  final AdditionController controller;
  final int index;
  final int level;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Positioned(
          bottom: 0,
          child: Row(
              children: List.generate(
            5,
            (final idx) => Icon(
              Icons.star,
              size: 15,
              color: idx < (controller.scoreSet[index]['score'] as int) &&
                      level == (controller.scoreSet[index]['level'] as int)
                  ? Colors.yellow
                  : Colors.grey, // Highlight stars
              // color: index < controller.score.value
              //     ? Colors.yellow
              //     : Colors.grey, // Highlight stars
            ),
          )),
        ));
  }
}

class _ButtonLevels extends StatelessWidget {
  _ButtonLevels({
    required this.level,
    this.w,
    this.h,
  });

  double? w = 70;
  double? h = 50;
  final int level;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AdditionController>();

    return Obx(
      () => IconButton(
          onPressed: () {
            for (int x = level;
                x <= controller.saveTheSuccessLevel.length;
                x++) {
              if (controller.saveTheSuccessLevel[x - 1] == level) {
                controller.level.value = level;
                controller.currentQuestionIndex.value = 0;
                Get.to(
                  () => QuizAdditionView(),
                );
                controller.startTimer();
                break;
              } else {
                print('You cant proceed');
              }
            }
          },
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: w,
                height: h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      controller.saveTheSuccessLevel.contains(level)
                          ? 'assets/images/active_level.png'
                          : 'assets/images/inactive_level.png',
                    ),
                    fit: BoxFit.cover,
                    // colorFilter: ColorFilter.mode(
                    //   addController?.level.value == 2
                    //       ? Colors.yellow
                    //       : Colors.grey.withOpacity(0.5), // Change color and opacity
                    //   BlendMode.srcATop, // Apply blending mode
                    // ),
                  ),
                ),
                child: Center(
                    child: Text(
                  level.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ),
              // Positioned(
              //   bottom: -4,
              //   child: Center(
              //     child: Row(
              //       children: [
              //         Row(
              //           children: List.generate(
              //             5,
              //             (final index) => Icon(
              //               Icons.star,
              //               size: 15,
              //               color: index <
              //                           (controller.scoreSet[1]['score']
              //                               as int) &&
              //                       level ==
              //                           (controller.scoreSet[1]['level'] as int)
              //                   ? Colors.yellow
              //                   : Colors.grey, // Highlight stars
              //               // color: index < controller.score.value
              //               //     ? Colors.yellow
              //               //     : Colors.grey, // Highlight stars
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          )),
    );
  }
}
