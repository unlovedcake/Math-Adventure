import 'package:get/get.dart';

import '../modules/addition/bindings/addition_binding.dart';
import '../modules/addition/views/addition_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static const ADDITION = Routes.ADDITION;

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
  ];
}
