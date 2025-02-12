import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/division_controller.dart';

class DivisionView extends GetView<DivisionController> {
  const DivisionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DivisionView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DivisionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
