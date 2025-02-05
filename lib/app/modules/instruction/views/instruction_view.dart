import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';

import '../controllers/instruction_controller.dart';

class InstructionView extends GetView<InstructionController> {
  const InstructionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent AppBar
        elevation: 0,
        title: Text("How to Play",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Colors.white)),

        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/app_bg.png'),
            fit: BoxFit.cover, // This makes the image cover the entire screen
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80,
              ),
              _buildAnimatedTitle("📖 Game Instructions"),
              SizedBox(height: 20),
              _buildInstructionStep(
                icon: Icons.calculate,
                title: "Solve the Equations",
                description:
                    "You will be given a set of five equations. Enter the correct answer to earn points.",
              ),
              _buildInstructionStep(
                icon: Icons.star,
                title: "Earning Stars",
                description:
                    "Each correct answer earns ⭐ one star point. Try to collect as many stars as possible!",
              ),
              _buildInstructionStep(
                icon: Icons.favorite,
                title: "Losing Lives",
                description:
                    "Every incorrect answer will ❌ subtract one heart. If you lose all hearts, the game is over!",
              ),
              _buildInstructionStep(
                icon: Icons.lightbulb,
                title: "Using Hints",
                description:
                    "You can use a hint 💡 once per game to help you find the correct answer. Use it wisely!",
              ),
              _buildInstructionStep(
                icon: Icons.emoji_events,
                title: "Winning & Losing",
                description:
                    "Try to finish all equations with the highest ⭐ stars possible before losing all ❤️ lives!",
              ),
              SizedBox(height: 20),
              Center(
                  child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xFF030f32), // Background color of the button
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Border radius of 10
                      side: BorderSide(
                        color: Colors.orange, // Border color orange
                        width: 2, // Border width
                      ),
                    ),
                  ),
                  child: Text(
                    "Got It",
                    style: TextStyle(
                        color: Colors.white, fontSize: 22), // Text color
                  ),
                ),
              )),
            ].animate(
              effects: [
                const FadeEffect(),
                const SaturateEffect(),
              ],
              interval: 600.ms,
            ).fade(
              duration: 600.ms,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInstructionStep(
      {required IconData icon,
      required String title,
      required String description}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 40, color: Color(0xFFb6d5f0)),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 16, color: Colors.tealAccent),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedTitle(String text) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(seconds: 1),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, -30 * (1 - value)),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
