import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:math_adventure/app/modules/multiplication/controllers/multiplication_controller.dart';
import 'package:math_adventure/app/routes/app_pages.dart';

class QuizMultiplicationView extends StatelessWidget {
  const QuizMultiplicationView({super.key});

  @override
  Widget build(BuildContext context) {
    final MultiplicationController controller =
        Get.put(MultiplicationController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF93c808),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 10,
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(0xFFb6d5f0),
                            radius: 20,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                if (controller.audioPlayerMusic.state ==
                                    PlayerState.playing) {
                                  controller.audioPlayerMusic.stop();
                                }

                                controller.timer?.cancel();
                                Get.back();
                              },
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Color(0xFFb6d5f0),
                            radius: 20,
                            child: IconButton(
                              icon: const Icon(
                                Icons.settings,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                controller.timer?.cancel();
                                if (controller.audioPlayerMusic.state ==
                                    PlayerState.playing) {
                                  controller.audioPlayerMusic.pause();
                                }

                                Get.toNamed(AppPages.SETTING);
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 6),
                        decoration: BoxDecoration(
                          color: Color(0xFFb6d5f0),
                          border: Border.all(
                            color: Colors.grey, // Border color
                            width: 4.0, // Border thickness
                          ),
                          borderRadius: BorderRadius.circular(
                              6), // Optional: rounded corners
                        ),
                        child: Text(
                          'LEVEL ${controller.level}',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          3,
                          (final index) => Icon(
                            Icons.favorite,
                            size: 30,
                            color: index < controller.lives.value
                                ? Colors.red
                                : Colors.grey, // Highlight stars
                          ),
                        ),
                      ),
                    ],
                  )),
              Obx(() => Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        controller.useHint();
                      },
                      icon: Container(
                        child: Lottie.asset(
                          'assets/lottie/hint.json',
                          width: 50,
                          fit: BoxFit.contain,
                          repeat: controller.availableHint.value == 1
                              ? true
                              : false,
                        ),
                      ),

                      // Icon(
                      //   Icons.lightbulb,
                      //   color: controller.availableHint.value == 1
                      //       ? Colors.orange
                      //       : Colors.grey,
                      //   size: 30,
                      // ),
                    ),
                  )),
              Obx(() => Center(
                    child: Column(
                      spacing: 20,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Column(
                            children: [
                              Row(
                                spacing: 14,
                                children: List.generate(
                                    controller.isCorrect.length, (index) {
                                  return Icon(
                                    controller.isCorrect[index]
                                        ? Icons.check_circle_rounded
                                        : Icons.cancel_rounded,
                                    color: controller.isCorrect[index]
                                        ? Colors.green
                                        : Colors.red,
                                    size: 20,
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                        Wrap(
                          runAlignment: WrapAlignment.center,
                          alignment: WrapAlignment.center,
                          runSpacing: 8,
                          spacing: 8, // Spacing between boxes
                          children: List.generate(
                              controller.currentWord.word.length, (index) {
                            return Container(
                              width: 50,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.white, // Border color
                                    width: 2.0, // Border thickness
                                  ),
                                ),
                              ),
                              child: Text(
                                controller.revealedLetters.value[index],
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  )),
              SizedBox(height: 20),
              Obx(() => Text(
                    controller.currentEquation.value,
                    style: TextStyle(
                      color: Color(0xFFb6d5f0),
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              SizedBox(height: 20),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: controller.choices
                        .map((choice) => ElevatedButton(
                              onPressed: () => controller.checkAnswer(choice),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFb6d5f0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                textStyle: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              child: Text(
                                "$choice",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                  color: Color(0xFF030f32),
                                ),
                              ),
                            ))
                        .toList(),
                  )),
              Obx(
                () => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Lottie.asset(
                              'assets/lottie/timer.json',
                              width: 80,
                              fit: BoxFit.contain,
                              repeat:
                                  controller.timeLeft.value != 0 ? true : false,
                            ),
                            Text(
                              controller.formattedTime,
                              style: const TextStyle(
                                color: Color(0xFFb6d5f0),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Text(
                            //   '⏳ ${controller.formattedTime}',
                            //   style: const TextStyle(
                            //     color: Color(0xFFb6d5f0),
                            //     fontSize: 20,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                          ],
                        ),
                        Row(
                          children: [
                            Row(
                              children: List.generate(
                                5,
                                (final index) => Icon(
                                  Icons.star,
                                  size: 30,
                                  color: index < controller.score.value ~/ 2
                                      ? Colors.yellow
                                      : Colors.grey, // Highlight stars
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ].animate(
              effects: [
                const FadeEffect(),
                const SaturateEffect(),
              ],
              interval: 300.ms,
            ).fade(
              duration: 800.ms,
            ),
          ),
        ),
      ),
    );
  }
}
