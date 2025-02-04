import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:math_adventure/app/modules/addition/controllers/addition_controller.dart';

class AdditionView extends GetView<AdditionController> {
  const AdditionView({super.key});
  @override
  Widget build(BuildContext context) {
    final AdditionController controller = Get.put(AdditionController());
    return Scaffold(
      backgroundColor: Color(0xFF030f32),
      appBar: AppBar(
          backgroundColor: Color(0xFF030f32),
          centerTitle: true,
          title: Obx(() => Text(
                'LEVEL ${controller.level}',
                style: TextStyle(
                  color: Color(0xFFb6d5f0),
                ),
              ))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '⏳ ${controller.formattedTime}',
                        style: const TextStyle(
                          color: Color(0xFFb6d5f0),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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
                      IconButton(
                        onPressed: () {
                          controller.useHint();
                        },
                        icon: Icon(
                          Icons.lightbulb,
                          color: controller.availableHint.value == 1
                              ? Colors.orange
                              : Colors.grey,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0),
                    child: Column(
                      children: [
                        Row(
                          children: List.generate(
                            5,
                            (final index) => Icon(
                              Icons.star,
                              size: 30,
                              color: index < controller.score.value
                                  ? Colors.yellow
                                  : Colors.grey, // Highlight stars
                            ),
                          ),
                        ),
                        Row(
                          spacing: 14,
                          children: List.generate(controller.isCorrect.length,
                              (index) {
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
                ],
              ),
            ),

            SizedBox(height: 20),
            // Obx(() => Text(
            //       "Hidden Word: ${controller.revealedLetters.value}",
            //       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            //     )),
            Obx(() => Center(
                  child: Wrap(
                    runAlignment: WrapAlignment.center,
                    alignment: WrapAlignment.center,
                    runSpacing: 8,
                    spacing: 8, // Spacing between boxes
                    children: List.generate(controller.currentWord.word.length,
                        (index) {
                      return Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          controller.revealedLetters.value[index],
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      );
                    }),
                  ),
                )),
            SizedBox(height: 20),
            Obx(() => Text(
                  controller.currentEquation.value,
                  style: TextStyle(
                    color: Color(0xFFb6d5f0),
                    fontSize: 34,
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
                                borderRadius: BorderRadius.circular(
                                    10), // Set border radius to 10
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              textStyle:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            child: Text(
                              "$choice",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                                color: Color(0xFF030f32),
                              ),
                            ),
                          ))
                      .toList(),
                )),
          ],
        ),
      ),
    );
  }
}
