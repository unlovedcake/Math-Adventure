import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:math_adventure/app/routes/app_pages.dart';

import '../controllers/select_operation_controller.dart';

class SelectOperationView extends GetView<SelectOperationController> {
  const SelectOperationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fancy Operations"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView.count(
            crossAxisCount: 2, // 2 Columns
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            shrinkWrap: true,
            children: [
              GestureDetector(
                  onTap: () {
                    Get.toNamed(AppPages.ADDITION);
                  },
                  child: operationButton(
                      Icons.add, [Colors.blue, Colors.cyan])), // Add
              operationButton(
                  Icons.remove, [Colors.red, Colors.orange]), // Minus
              operationButton(
                  Icons.close, [Colors.purple, Colors.pink]), // Multiply
              operationButton(Icons.horizontal_rule,
                  [Colors.yellow, Colors.grey]), // Divide
            ],
          ),
        ),
      ),
    );
  }

  Widget operationButton(IconData icon, List<Color> gradientColors) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // Square with rounded corners
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: gradientColors.last.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          icon,
          size: 100,
          color: Colors.white,
        ),
      ),
    );
  }
}
