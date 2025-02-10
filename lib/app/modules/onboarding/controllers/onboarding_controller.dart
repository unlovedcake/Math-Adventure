import 'package:get/get.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';

class OnboardingController extends GetxController {
  final LiquidController liquidController = LiquidController();

  final List<String> images = [
    "assets/images/2.png",
    "assets/images/3.png",
    "assets/images/4.png",
    "assets/images/5.png",
    "assets/images/6.png",
  ];

  final RxInt currentIndex = 0.obs;

  // Go to the next page
  void nextPage() {
    if (currentIndex.value < images.length - 1) {
      currentIndex.value++;
      liquidController.animateToPage(page: currentIndex.value);
    }
  }

  // Go to the previous page
  void previousPage() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      liquidController.animateToPage(page: currentIndex.value);
    }
  }

  // Skip to the last page
  void skipToLast() {
    currentIndex.value = images.length - 1;
    liquidController.animateToPage(page: currentIndex.value);
  }

  // Update the current index when page changes
  void updateIndex(int index) {
    currentIndex.value = index;
  }
}
