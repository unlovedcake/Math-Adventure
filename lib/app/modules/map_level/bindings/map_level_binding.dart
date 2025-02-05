import 'package:get/get.dart';

import '../controllers/map_level_controller.dart';

class MapLevelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapLevelController>(
      () => MapLevelController(),
    );
  }
}
