import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:math_adventure/app/data/model/constants/global_variable.dart';
import 'package:math_adventure/app/data/model/word_model.dart';

class MinusController extends GetxController {
  final int totalLives = 3;
  final int totalEquations = 10;
  final int totalTime = 180;

  final RxInt level = 1.obs;
  final RxInt lives = 3.obs;
  final RxInt score = 0.obs;

  final RxString revealedLetters = ''.obs;
  final RxInt timeLeft = 180.obs;
  final RxInt currentQuestionIndex = 0.obs;
  final RxString currentEquation = ''.obs;
  final RxInt correctAnswer = 0.obs;
  final RxList<int> choices = <int>[].obs;
  final RxList<int> saveTheSuccessLevel = <int>[].obs;

  final RxInt randomNumber = 10.obs;

  final RxInt currentWordListIndex = 0.obs;
  final RxList<bool> isCorrect = <bool>[].obs;

  final RxInt availableHint = 1.obs;

  // final RxSet<int> scores = <int>{}.obs;

  var scoreSet = <Map<String, dynamic>>[
    {'score': 0, 'level': 1},
    {'score': 0, 'level': 2},
    {'score': 0, 'level': 3},
    {'score': 0, 'level': 4},
    {'score': 0, 'level': 5},
    {'score': 0, 'level': 6},
    {'score': 0, 'level': 7},
    {'score': 0, 'level': 8},
    {'score': 0, 'level': 9},
    {'score': 0, 'level': 10},
  ].obs;

  Timer? timer;
  List<Map<String, dynamic>> equations = <Map<String, dynamic>>[];

  late WordModel currentWord;

  final List<WordModel> wordList = <WordModel>[
    WordModel(
        word: "DIGITS",
        meaning:
            "Typically refers to numbers written out in words instead of numerals."),
    WordModel(
        word: "INFINITY",
        meaning:
            "something that is endless, limitless, or unbounded. It is often used in mathematics, physics, and philosophy to represent something that goes on forever."),
    WordModel(word: "Happy", meaning: "Happy means feeling joy and pleasure."),
    WordModel(
        word: "SPHERE",
        meaning:
            "is a perfectly round three-dimensional object where every point on its surface is equidistant from its center. It is similar to a ball or a globe."),
    WordModel(
        word: "EUCLID",
        meaning:
            'was an ancient Greek mathematician, often called the "Father of Geometry." He lived around 300 BCE and wrote the famous book "Elements," which laid the foundation for modern geometry.'),
    WordModel(
        word: "GREATER THAN",
        meaning:
            "means larger, bigger, or more than something else in size, number, value, or importance."),
    WordModel(
        word: "BAR GRAPH",
        meaning:
            "s a type of chart that uses rectangular bars to represent data. The length or height of each bar is proportional to the value it represents."),
    WordModel(word: "Happy", meaning: "Happy means feeling joy and pleasure."),
    WordModel(
        word: "NEWTON",
        meaning:
            "was a famous English mathematician, physicist, and astronomer who made groundbreaking contributions to science. He is best known for his laws of motion and universal gravitation, which laid the foundation for classical physics."),
    WordModel(
        word: "PLACE VALUE",
        meaning:
            "refers to the value of each digit in a number based on its position. Each digit's place determines its actual worth."),
    WordModel(
        word: "ROMAN NUMERALS",
        meaning:
            "are a number system used in ancient Rome, where letters represent numbers instead of digits (0-9)."),
    WordModel(
        word: "KHAYYAM",
        meaning:
            "was a Persian mathematician, astronomer, philosopher, and poet. He is best known for mathematics and algebra."),
  ];

  final RxList<int> indices = <int>[].obs;

  final RxList<int> randomHiddenWordIndex = <int>[].obs;

  final AudioPlayer audioPlayerSound = AudioPlayer();
  final AudioPlayer audioPlayerMusic = AudioPlayer();

  final isSoundOn = false.obs;

  @override
  void onInit() {
    super.onInit();
    initializeRandomEquation();
  }

  @override
  void onClose() {
    timer?.cancel();
    audioPlayerSound.dispose();
    audioPlayerMusic.dispose();
    super.onClose();
  }

  void playMusic() async {
    try {
      if (isMusicIsOn.value && currentRoute.value == "/QuizMinusView") {
        // Play audio when turned ON
        await audioPlayerMusic.play(
          AssetSource('audio/music_minus.mp3'),
        );
        await audioPlayerMusic.setReleaseMode(ReleaseMode.loop);
      } else {
        audioPlayerMusic.stop();
        debugPrint('Music Off ${isMusicIsOn.value} ${currentRoute.value}');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void playSound(String path) async {
    try {
      if (isSoundIsOn.value) {
        await audioPlayerSound.play(
          AssetSource(path),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void initializeRandomEquation() {
    saveTheSuccessLevel.add(level.value);
    _randomTheIndexOfWordList();
    // _randomHiddenWordIndex();
    _generateEquations();

    _loadQuestion();

    revealedLetters.value = " " * currentWord.word.length;
    // " " * currentWord.word.replaceAll(RegExp(r'\s+'), '').length;

    for (int i = 0; i < currentWord.word.length; i++) {
      if (revealedLetters.value[i] == ' ') {
        randomHiddenWordIndex.add(i);
      }
    }
  }

  void _randomTheIndexOfWordList() {
    indices.value = List.generate(wordList.length, (index) => index);
    indices.shuffle(); // Shuffle the list of words
    currentWord = wordList[indices[currentWordListIndex.value]];
  }

  void _generateEquations() {
    Random random = Random();
    equations.clear();

    for (int i = 0; i < totalEquations; i++) {
      int num1 = random.nextInt(randomNumber.value) + 10;
      int num2 = random.nextInt(num1);
      int answer = num1 - num2;
      equations.add({
        "question": "$num1 - $num2 = ?",
        "answer": answer,
      });
    }
  }

  void _loadQuestion() {
    if (currentQuestionIndex.value < equations.length) {
      currentEquation.value = equations[currentQuestionIndex.value]["question"];
      correctAnswer.value = equations[currentQuestionIndex.value]["answer"];
      _generateChoices();
    } else {
      endGame(true);
    }
  }

  String get formattedTime {
    int minutes = (timeLeft.value / 60).floor();
    int seconds = timeLeft.value % 60;
    return "${minutes.toString().padLeft(1, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft.value > 0) {
        timeLeft.value--;
      } else {
        endGame(false);
      }
    });
  }

  void _generateChoices() {
    Random random = Random();
    Set<int> options = {correctAnswer.value};

    while (options.length < 3) {
      int fakeAnswer = random.nextInt(randomNumber.value) - 2;
      if (fakeAnswer != correctAnswer.value && fakeAnswer > 0) {
        options.add(fakeAnswer);
      }
    }

    choices.value = options.toList()..shuffle();
  }

  RxInt scoreStar = 0.obs;
  int starScore(int score) {
    switch (score) {
      case 2:
        return scoreStar.value = 1;
      case 4:
        return scoreStar.value = 2;
      case 6:
        return scoreStar.value = 3;
      case 8:
        return scoreStar.value = 4;
      case 10:
        return scoreStar.value = 5;
    }
    return scoreStar.value;
  }

  void checkAnswer(int selectedAnswer) {
    //if (audioPlayerSound.state == PlayerState.playing) return;

    if (selectedAnswer == correctAnswer.value) {
      playSound('audio/correct_sound.wav');
      score.value++;

      //scoreSet.add({'score': score.value, 'level': level.value});
      scoreSet[level.value - 1] = {
        ...scoreSet[level.value - 1], // Keep existing values
        'score': starScore(score.value),
      };

      isCorrect.add(true);
      revealNextLetter();
    } else {
      playSound('audio/wrong_sound.wav');
      lives.value--;
      isCorrect.add(false);
    }

    if (lives.value == 0) {
      endGame(false);

      return;
    }

    currentQuestionIndex.value++;
    if (currentQuestionIndex.value < equations.length) {
      _loadQuestion();
    } else {
      revealedLetters.value = currentWord.word;
      endGame(true);
    }
  }

  Random random = Random();
  void revealNextLetter() {
    List<String> letters = revealedLetters.value.split('');

    int randomElement =
        randomHiddenWordIndex[random.nextInt(randomHiddenWordIndex.length)];

    String letterToReveal = currentWord.word[randomElement];

    for (int i = 0; i < currentWord.word.length; i++) {
      if (currentWord.word[i].toLowerCase() == letterToReveal.toLowerCase()) {
        letters[i] = currentWord.word[i];
        randomHiddenWordIndex.removeWhere((element) => element == i);
      }
    }

    revealedLetters.value = letters.join('');

    if (revealedLetters.value == currentWord.word) {
      // if hidden word is fully revealed call the endGame

      revealedLetters.value = currentWord.word;
      score.value = 10;
      scoreSet[level.value - 1]['score'] = starScore(score.value);

      // scoreSet[level.value - 1] = {
      //   ...scoreSet[level.value - 1], // Keep existing values
      //   'score': starScore(score.value),
      // };
      endGame(true);
      return;
    }

    // if (score.value == 5) {
    //   revealedLetters.value = currentWord.word; // reveal full word
    // } else {
    //   revealedLetters.value = letters.join('');

    //   if (revealedLetters.value == currentWord.word) {
    //     // if hidden word is fully revealed call the endGame
    //     endGame(true);
    //   }
    // }
  }

  void useHint() {
    if (availableHint.value == 1) {
      playSound('audio/hint_sound.wav');
      List<String> letters = revealedLetters.value.split('');

      for (int i = 0; i < currentWord.word.length; i++) {
        if (revealedLetters.value[i] == ' ') {
          letters[i] = currentWord.word[i];
          randomHiddenWordIndex.removeWhere((element) => element == i);
          break;
        }
      }

      revealedLetters.value = letters.join('');
      availableHint.value = 0;

      if (revealedLetters.value == currentWord.word) {
        // if hidden word is fully revealed call the endGame

        endGame(true);
        return;
      }
    }
  }

  void endGame(bool completed) {
    timer?.cancel();

    completed
        ? Get.dialog(
            barrierDismissible: false,
            AlertDialog(
              backgroundColor: Color(0xFFf5d542),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Rounded corners
                side: const BorderSide(
                  color: Color(0xFF492100),

                  width: 8, // Border width
                ),
              ),
              title: Center(
                  child: Text(
                "Level ${level.value} Completed!",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              )),
              content: Stack(
                children: [
                  Lottie.asset(
                    'assets/lottie/fireworks.json',
                    fit: BoxFit.cover,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          5,
                          (final index) => Icon(
                            Icons.star,
                            size: 20,
                            color: index < score.value ~/ 2
                                ? Colors.yellow
                                : Colors.grey, // Highlight stars
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Obx(() => Wrap(
                            runAlignment: WrapAlignment.center,
                            alignment: WrapAlignment.center,
                            runSpacing: 8,
                            spacing: 8, // Spacing between boxes
                            children: List.generate(
                                revealedLetters.value.length, (index) {
                              return Container(
                                width: 40,
                                height: 40,
                                alignment: Alignment.center,
                                // decoration: BoxDecoration(
                                //   border: Border(
                                //     bottom: BorderSide(
                                //       color: Colors.white, // Border color
                                //       width: 2.0, // Border thickness
                                //     ),
                                //   ),
                                // ),
                                child: Text(
                                  revealedLetters.value[index],
                                  style: TextStyle(
                                      color: Color(0xFF492100),
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }),
                          )),
                      Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(10),
                          // decoration: BoxDecoration(
                          //     color: Color(0xFFb6d5f0),
                          //     borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            currentWord.meaning,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          )),
                    ],
                  ),
                ],
              ),
              actions: [
                Row(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // OutlinedButton(
                    //   style: OutlinedButton.styleFrom(
                    //     backgroundColor: Colors.red.shade300,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(
                    //           10), // Set border radius to 10
                    //     ),
                    //     padding:
                    //         EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    //     textStyle: TextStyle(fontSize: 20, color: Colors.white),
                    //   ),
                    //   onPressed: () {
                    //     Get.back();
                    //     restartGame();
                    //   },
                    //   child:
                    //       Text("Retry", style: TextStyle(color: Colors.black)),
                    // ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        textStyle: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () {
                        if (level.value == 10) {
                          Get.back();
                          playSound('audio/level_completed_sound.wav');

                          congrats();
                        } else {
                          if (audioPlayerMusic.state == PlayerState.playing) {
                            audioPlayerMusic.stop();
                          }
                          nextLevel();
                          Get.back();
                          Get.back();
                        }
                      },
                      child: Text(
                        'Continue',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        : Get.dialog(
            barrierDismissible: false,
            AlertDialog(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Rounded corners
                side: const BorderSide(
                  color: Colors.red,
                  width: 8, // Border width
                ),
              ),
              title: Center(
                  child: lives.value == 0
                      ? Text("Out of lives!")
                      : Text("Ran out of time!")),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  lives.value == 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            3,
                            (final index) => Icon(
                              Icons.favorite,
                              size: 30,
                              color: index < lives.value
                                  ? Colors.red
                                  : Colors.grey, // Highlight stars
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/lottie/timer.json',
                              width: 80,
                              fit: BoxFit.contain,
                              repeat: timeLeft.value != 0 ? true : false,
                            ),
                            // Text(
                            //   formattedTime,
                            //   style: const TextStyle(
                            //     color: Colors.black,
                            //     fontSize: 20,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                            // Text(
                            //   '⏳ ${controller.formattedTime}',
                            //   style: const TextStyle(
                            //     color: Color(0xFFb6d5f0),
                            //     fontSize: 20,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                          ],
                        ),
                  Lottie.asset(
                    'assets/lottie/game_over.json',
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              actions: [
                Center(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      textStyle: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () {
                      Get.back();
                      timeLeft.value = totalTime;
                      restartGame();
                    },
                    child: Text(
                      'Retry',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );

    if (completed) {
      playSound('audio/success_sound.wav');
    } else {
      playSound('audio/fail_sound.wav');
    }
  }

  void congrats() {
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded corners
          // side: const BorderSide(
          //   color: Colors.white, // Border color
          //   width: 8, // Border width
          // ),
        ),
        title: Center(
            child: Text(
          "Congratulation!",
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Lottie.asset(
                  'assets/lottie/congrats.json',
                  width: 250,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Congratulations on completing the quiz task! Your hard work and dedication truly paid off!",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ],
        ),
        actions: [
          Row(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  textStyle: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () {
                  Get.back();
                  currentWordListIndex.value = 0;
                  restartGame();
                },
                child: Text(
                  'Close',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    // Get.defaultDialog(
    //   barrierDismissible: false,
    //   title: 'Congratulation',
    //   content: Stack(
    //     alignment: Alignment.center,
    //     children: [
    //       Lottie.asset(
    //         'assets/lottie/congrats.json',
    //         width: 250,
    //         fit: BoxFit.cover,
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Text(
    //           "Congratulations on completing the quiz task! Your hard work and dedication truly paid off!",
    //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    //           textAlign: TextAlign.center,
    //         ),
    //       )
    //     ],
    //   ),
    //   textConfirm: "Close",
    //   onConfirm: () {
    //     Get.back();
    //     currentWordListIndex.value = 0;
    //     restartGame();
    //   },
    // );
  }

  void restartGame() {
    timer?.cancel();
    currentQuestionIndex.value = 0;

    lives.value = totalLives;
    level.value = 1;
    score.value = 0;
    timeLeft.value = totalTime;

    availableHint.value = 1;
    randomNumber.value = 10;

    isCorrect.clear();
    indices.clear();
    randomHiddenWordIndex.clear();

    _randomTheIndexOfWordList();
    currentWord = wordList[indices[currentWordListIndex.value]];
    revealedLetters.value = " " * currentWord.word.length;
    //_randomHiddenWordIndex();

    _generateEquations();
    _loadQuestion();
    startTimer();
    for (int i = 0; i < currentWord.word.length; i++) {
      if (revealedLetters.value[i] == ' ') {
        randomHiddenWordIndex.add(i);
      }
    }
  }

  void nextLevel() async {
    try {
      if (level.value != 10) {
        currentWordListIndex.value++;
        level.value++;
        randomNumber.value += 5;
      }

      saveTheSuccessLevel.add(level.value);

      // currentWord = wordList[indices[currentWordListIndex.value]];
      currentWord =
          wordList.elementAt(indices.elementAt(currentWordListIndex.value));

      //currentWord = wordList[currentWordListIndex.value];

      score.value = 0;
      timeLeft.value = totalTime;
      currentQuestionIndex.value = 0;
      revealedLetters.value = " " * currentWord.word.length;
      isCorrect.clear();
      randomHiddenWordIndex.clear();

      availableHint.value = 1;
      //_randomHiddenWordIndex();
      _generateEquations();
      _loadQuestion();
      lives.value = totalLives;

      for (int i = 0; i < currentWord.word.length; i++) {
        if (revealedLetters.value[i] == ' ') {
          randomHiddenWordIndex.add(i);
        }
      }
      //startTimer();
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  String countTheScoreStar(int scoreStar) {
    String path = 'assets/images/0star.png';

    switch (scoreStar) {
      case 0:
        path = 'assets/images/0star.png';
      case 1:
        path = 'assets/images/1star.png';
      case 2:
        path = 'assets/images/2star.png';
      case 3:
        path = 'assets/images/3star.png';
      case 4:
        path = 'assets/images/4star.png';
      case 5:
        path = 'assets/images/5star.png';
    }
    return path;

    // if (index < (scoreSet[index]['score'] as int) &&
    //     lvl == (scoreSet[index]['level'] as int)) {
    //   return Colors.yellow;
    // } else {
    //   return Colors.grey;
    // }
  }
}
