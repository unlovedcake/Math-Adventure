import 'package:get/get.dart';
import 'package:math_adventure/app/modules/home/controllers/home_controller.dart';

import '../controllers/addition_controller.dart';

class AdditionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(), permanent: true);
  }
}
