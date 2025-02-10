import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/minus_controller.dart';

class MinusView extends GetView<MinusController> {
  const MinusView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MinusView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MinusView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
