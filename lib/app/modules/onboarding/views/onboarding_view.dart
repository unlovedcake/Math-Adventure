import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:liquid_swipe/Helpers/Helpers.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:math_adventure/app/routes/app_pages.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    return Scaffold(
      body: Stack(
        children: [
          // LiquidSwipe with images
          LiquidSwipe(
            pages: controller.images
                .map((image) => ImagePage(imagePath: image))
                .toList(),

            liquidController: controller.liquidController,
            fullTransitionValue: 700,
            enableLoop: false, // Disable loop to allow skip
            waveType: WaveType.liquidReveal,
            positionSlideIcon: 0.8,
            slideIconWidget: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPageChangeCallback: (pageIndex) {
              controller.updateIndex(pageIndex); // Update page index
            },
          ),
          // Dots indicator
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Obx(() {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    controller.images.length,
                    (index) => AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      width: controller.currentIndex.value == index ? 20 : 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: controller.currentIndex.value == index
                            ? Colors.blue
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          Positioned(
            bottom: 50,
            left: 100,
            child: ElevatedButton(
              onPressed: controller.previousPage,
              child: Text("Previous"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
              ),
            ),
          ),

          Positioned(
            bottom: 50,
            left: 20,
            child: ElevatedButton(
              onPressed: controller.nextPage,
              child: Text("Next"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
              ),
            ),
          ),

          // Get Started Button (Only on Last Page)
          Obx(() {
            return controller.currentIndex.value != controller.images.length - 1
                ? Positioned(
                    bottom: 50,
                    right: 20,
                    child: ElevatedButton(
                      onPressed: controller.skipToLast,
                      child: Text("Skip"),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                      ),
                    ),
                  )
                : Positioned(
                    bottom: 50,
                    right: 20,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.offNamed(AppPages.INTRODUCINGAERO);
                      },
                      child: Text("Get Started"),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  );
          }),
        ],
      ),
    );
  }
}

class ImagePage extends StatelessWidget {
  final String imagePath;

  ImagePage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class OnboardingView extends StatefulWidget {
//   const OnboardingView({super.key});

//   @override
//   _OnboardingViewState createState() => _OnboardingViewState();
// }

// class _OnboardingViewState extends State<OnboardingView> {
//   final _controller = PageController();
//   int _currentPage = 0;

//   final List<Map<String, String>> splashData = [
//     {
//       "title": "Explore Wiko\nBoarding",
//       "subtitle":
//           "Gratitude is the most heartwarming\nfeeling. Praise someone in the\neasiest way possible",
//       "image": "assets/images/2.png"
//     },
//     {
//       "title": "Get Experience",
//       "subtitle":
//           "Browse kudos list. See what your\ncommunity is up to and\nget inspired",
//       "image": "assets/images/3.png"
//     },
//     {
//       "title": "Application\nMedia",
//       "subtitle":
//           "Do your best in your day to day life\nand unlock achievements",
//       "image": "assets/images/4.png"
//     },
//   ];

//   AnimatedContainer _buildDots({int? index}) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 200),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(
//           Radius.circular(50),
//         ),
//         color: const Color(0xFF293241),
//       ),
//       margin: const EdgeInsets.only(right: 5),
//       height: 10,
//       curve: Curves.easeIn,
//       width: _currentPage == index ? 20 : 10,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: <Widget>[
//             Expanded(
//               flex: 3,
//               child: PageView.builder(
//                 controller: _controller,
//                 itemCount: splashData.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Container(
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage(splashData[index]['image']!),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     child: Column(
//                       children: <Widget>[
//                         SizedBox(
//                           height: 30.0,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 15.0),
//                           child: Text(
//                             splashData[index]['title']!.toUpperCase(),
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontFamily: "Sofia",
//                               fontSize: 27,
//                               fontWeight: FontWeight.w800,
//                               color: const Color(0xFF424242),
//                             ),
//                           ),
//                         ),
//                         Text(
//                           splashData[index]['subtitle']!,
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontFamily: "Sofia",
//                             fontSize: 15,
//                             color: Colors.grey[400],
//                             height: 1.5,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 30.0,
//                         ),
//                         // AspectRatio(
//                         //   aspectRatio: 12 / 9,
//                         //   child: Image.asset(
//                         //     splashData[index]['image']!,
//                         //     fit: BoxFit.contain,
//                         //   ),
//                         // ),
//                         Spacer(),
//                       ],
//                     ),
//                   );
//                 },
//                 onPageChanged: (value) => setState(() => _currentPage = value),
//               ),
//             ),
//             Expanded(
//               flex: 1,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.only(top: 40.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: List.generate(
//                         splashData.length,
//                         (int index) => _buildDots(index: index),
//                       ),
//                     ),
//                   ),
//                   Spacer(),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                     child: SizedBox(
//                       height: 45,
//                       width: MediaQuery.of(context).size.width,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           _controller.nextPage(
//                             duration: const Duration(milliseconds: 200),
//                             curve: Curves.easeIn,
//                           );
//                         },
//                         child: Text(
//                           _currentPage + 1 == splashData.length
//                               ? 'Go to app'
//                               : 'Next',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontFamily: "Sofia",
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Spacer(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

