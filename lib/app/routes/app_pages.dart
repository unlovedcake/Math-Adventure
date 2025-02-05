import 'package:get/get.dart';

import '../modules/addition/bindings/addition_binding.dart';
import '../modules/addition/views/addition_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/instruction/bindings/instruction_binding.dart';
import '../modules/instruction/views/instruction_view.dart';
import '../modules/map_level/bindings/map_level_binding.dart';
import '../modules/map_level/views/map_level_view.dart';
import '../modules/select_operation/bindings/select_operation_binding.dart';
import '../modules/select_operation/views/select_operation_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static const ADDITION = Routes.ADDITION;

  static const INSTRUCTION = Routes.INSTRUCTION;

  static const SELECTOPERATION = Routes.SELECT_OPERATION;
  static const MAPLEVEL = Routes.MAP_LEVEL;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ADDITION,
      page: () => const AdditionView(),
      binding: AdditionBinding(),
    ),
    GetPage(
      name: _Paths.INSTRUCTION,
      page: () => const InstructionView(),
      binding: InstructionBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_OPERATION,
      page: () => const SelectOperationView(),
      binding: SelectOperationBinding(),
    ),
    GetPage(
      name: _Paths.MAP_LEVEL,
      page: () => const MapLevelView(),
      binding: MapLevelBinding(),
    ),
  ];
}
