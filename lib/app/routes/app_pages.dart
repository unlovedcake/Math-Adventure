import 'package:get/get.dart';

import '../modules/addition/bindings/addition_binding.dart';
import '../modules/addition/views/addition_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/instruction/bindings/instruction_binding.dart';
import '../modules/instruction/views/instruction_view.dart';
import '../modules/introducing_aero/bindings/introducing_aero_binding.dart';
import '../modules/introducing_aero/views/introducing_aero_view.dart';
import '../modules/map_level/bindings/map_level_binding.dart';
import '../modules/map_level/views/map_level_view.dart';
import '../modules/minus/bindings/minus_binding.dart';
import '../modules/minus/views/minus_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/select_operation/bindings/select_operation_binding.dart';
import '../modules/select_operation/views/select_operation_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/views/setting_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const SPLASH = Routes.SPLASH;

  static const ONBOARDING = Routes.ONBOARDING;

  static const INTRODUCINGAERO = Routes.INTRODUCING_AERO;

  static const INITIAL = Routes.HOME;

  static const SETTING = Routes.SETTING;

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
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.INTRODUCING_AERO,
      page: () => const IntroducingAeroView(),
      binding: IntroducingAeroBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.MINUS,
      page: () => const MinusView(),
      binding: MinusBinding(),
    ),
  ];
}
