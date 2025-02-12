import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/select_operation_controller.dart';

class SelectOperationView extends GetView<SelectOperationController> {
  const SelectOperationView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SelectOperationController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'SELECT AN OPERATION',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: CircleAvatar(
          backgroundColor: Color(0xFFb6d5f0).withValues(alpha: 0.5),
          radius: 20,
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.all(40.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/app_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: List.generate(controller.operators.length, (index) {
                bool isLastOdd = controller.operators.length % 2 == 1 &&
                    index == controller.operators.length - 1;
                return InkWell(
                  onTap: () => controller
                      .navigateTo(controller.operators[index]['route']),
                  child: Container(
                    width: isLastOdd
                        ? constraints.maxWidth / 2 - 4
                        : constraints.maxWidth / 2 - 8,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        controller.operators[index]['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),
      // body: Center(
      //   child: Padding(
      //     padding: const EdgeInsets.all(20.0),
      //     child: GridView.count(
      //       crossAxisCount: 2, // 2 Columns
      //       crossAxisSpacing: 20,
      //       mainAxisSpacing: 20,
      //       shrinkWrap: true,
      //       children: [
      //         GestureDetector(
      //             onTap: () {
      //               Get.toNamed(AppPages.ADDITION);
      //             },
      //             child: operationButton(
      //                 Icons.add, [Colors.blue, Colors.cyan])), // Add
      //         operationButton(
      //             Icons.remove, [Colors.red, Colors.orange]), // Minus
      //         operationButton(
      //             Icons.close, [Colors.purple, Colors.pink]), // Multiply
      //         operationButton(Icons.horizontal_rule,
      //             [Colors.yellow, Colors.grey]), // Divide
      //       ],
      //     ),
      //   ),
      // ),
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
            color: gradientColors.last.withValues(alpha: 0.5),
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
