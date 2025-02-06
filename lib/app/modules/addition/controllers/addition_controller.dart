import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:math_adventure/app/data/model/word_model.dart';

class AdditionController extends GetxController {
  final int totalLives = 3;
  final int totalEquations = 5;
  final int totalTime = 180;

  final RxInt level = 1.obs;
  final lives = 3.obs;
  final score = 0.obs;
  final revealedLetters = ''.obs;
  final timeLeft = 180.obs;
  final currentQuestionIndex = 0.obs;
  final currentEquation = ''.obs;
  final correctAnswer = 0.obs;
  final choices = <int>[].obs;
  final saveTheSuccessLevel = <int>[].obs;

  final randomNumber = 10.obs;

  final currentWordListIndex = 0.obs;
  final isCorrect = <bool>[].obs;

  final availableHint = 1.obs;

  Timer? timer;
  List<Map<String, dynamic>> equations = [];

  late WordModel currentWord;

  final List<WordModel> wordList = [
    WordModel(
        word: "Rene Descartes",
        meaning:
            "He was a Mathematician, Philosopher, and Scientist. He invented the cartesian coordinate system or known as cartesian plane."),
    WordModel(
        word: "Lovely",
        meaning: "Lovely means charming, delightful, or beautiful."),
    WordModel(word: "Happy", meaning: "Happy means feeling joy and pleasure."),
    WordModel(
        word: "Brave",
        meaning: "Brave means showing courage in difficult situations."),
    WordModel(
        word: "Smart",
        meaning: "Smart means having intelligence and quick thinking."),
  ];

  final indices = [].obs;

  final randomHiddenWordIndex = [].obs;

  @override
  void onInit() {
    saveTheSuccessLevel.add(level.value);
    _randomTheIndexOfWordList();

    _randomHiddenWordIndex(currentWord.word.length);
    _generateEquations();

    _loadQuestion();

    revealedLetters.value = "-" * currentWord.word.length;
    super.onInit();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  void _randomTheIndexOfWordList() {
    indices.value = List.generate(wordList.length, (index) => index);
    indices.shuffle(); // Shuffle the list to randomize order
    currentWord = wordList[indices[currentWordListIndex.value]];
  }

  void _randomHiddenWordIndex(int wordLength) {
    randomHiddenWordIndex.value = List.generate(wordLength, (index) => index);
    randomHiddenWordIndex.shuffle(); // Shuffle the list to randomize order
  }

  void _generateEquations() {
    Random random = Random();
    equations.clear();

    for (int i = 0; i < totalEquations; i++) {
      int num1 = random.nextInt(randomNumber.value) + 1;
      int num2 = random.nextInt(randomNumber.value) + 1;
      int answer = num1 + num2;
      equations.add({
        "question": "$num1 + $num2 = ?",
        "answer": answer,
      });
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

  void _loadQuestion() {
    if (currentQuestionIndex.value < equations.length) {
      currentEquation.value = equations[currentQuestionIndex.value]["question"];
      correctAnswer.value = equations[currentQuestionIndex.value]["answer"];
      _generateChoices();
    } else {
      endGame(true);
    }
  }

  void _generateChoices() {
    Random random = Random();
    Set<int> options = {correctAnswer.value};

    while (options.length < 3) {
      int fakeAnswer =
          correctAnswer.value + random.nextInt(randomNumber.value) - 2;
      if (fakeAnswer != correctAnswer.value && fakeAnswer > 0) {
        options.add(fakeAnswer);
      }
    }

    choices.value = options.toList()..shuffle();
  }

  void checkAnswer(int selectedAnswer) {
    if (selectedAnswer == correctAnswer.value) {
      score.value++;
      isCorrect.add(true);
      revealNextLetter();
    } else {
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
      endGame(true);
    }
  }

  Random random = Random();
  void revealNextLetter() {
    if (score.value <= currentWord.word.length) {
      print('JPY ${randomHiddenWordIndex}');

      List<String> letters = revealedLetters.value.split('');

      // Reveal all instances of the next hidden letter
      String letterToReveal =
          currentWord.word[randomHiddenWordIndex[score.value - 1]];

      for (int i = 0; i < currentWord.word.length; i++) {
        if (currentWord.word[i].toLowerCase() == letterToReveal.toLowerCase()) {
          letters[i] = currentWord.word[i];
        }
      }

      if (score.value == 5) {
        revealedLetters.value = currentWord.word; // reveal full word
      } else {
        revealedLetters.value = letters.join('');

        if (revealedLetters.value == currentWord.word) {
          // if hidden word is fully revealed call the endGame
          endGame(true);
          return;
        }
      }
    }
  }

  void useHint() {
    if (availableHint.value == 1) {
      List<String> letters = revealedLetters.value.split('');

      for (int i = 0; i < currentWord.word.length; i++) {
        if (revealedLetters.value[i] == '-') {
          letters[i] = currentWord.word[i];
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
              backgroundColor: Color(0xFFb6d5f0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Rounded corners
                side: const BorderSide(
                  color: Colors.white, // Border color
                  width: 8, // Border width
                ),
              ),
              title: Center(child: Text("Level ${level.value} Completed!")),
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
                            color: index < score.value
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
                            children:
                                List.generate(currentWord.word.length, (index) {
                              return Container(
                                width: 40,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.white, // Border color
                                      width: 2.0, // Border thickness
                                    ),
                                  ),
                                ),
                                child: Text(
                                  revealedLetters.value[index],
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }),
                          )),
                      Container(
                          margin: EdgeInsets.all(20),
                          color: Color(0xFFb6d5f0),
                          padding: EdgeInsets.all(10),
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Set border radius to 10
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        textStyle: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () {
                        Get.back();
                        restartGame();
                      },
                      child:
                          Text("Retry", style: TextStyle(color: Colors.black)),
                    ),
                    Obx(() => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            textStyle:
                                TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          onPressed: () {
                            if (level.value == 5) {
                              Get.back();
                              congrats();
                            } else {
                              nextLevel();
                              Get.back();
                              Get.back();
                            }
                          },
                          child: Text(
                            level.value == 5 ? "Continue" : "Next Level",
                            style: TextStyle(color: Colors.black),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          )
        : Get.dialog(
            barrierDismissible: false,
            AlertDialog(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Rounded corners
                side: const BorderSide(
                  color: Colors.white, // Border color
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
                      : Text(timeLeft.value.toString()),
                  Lottie.asset(
                    'assets/lottie/game_over.json',
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              actions: [
                Row(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        textStyle: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () {
                        Get.back();
                        timeLeft.value = totalTime;
                        restartGame();
                      },
                      child: Text(
                        'Retry',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );

    // Get.defaultDialog(
    //     barrierDismissible: false,
    //     title: lives.value == 0 ? "Out of lives" : 'Ran out of time',
    //     content: Column(
    //       children: [
    //         Lottie.asset(
    //           'assets/lottie/game_over.json',
    //           width: 150,
    //           fit: BoxFit.cover,
    //         ),
    //       ],
    //     ),
    //     textConfirm: "Restart",
    //     onConfirm: () {
    //       Get.back();
    //       restartGame();
    //     },
    //   );
  }

  void congrats() {
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        backgroundColor: Color(0xFFb6d5f0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded corners
          side: const BorderSide(
            color: Colors.white, // Border color
            width: 8, // Border width
          ),
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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

    _randomTheIndexOfWordList();
    currentWord = wordList[indices[currentWordListIndex.value]];
    revealedLetters.value = "-" * currentWord.word.length;
    _randomHiddenWordIndex(currentWord.word.length);
    _generateEquations();
    _loadQuestion();
    startTimer();
  }

  void nextLevel() {
    try {
      if (level.value != 5) {
        currentWordListIndex.value++;
        level.value++;
        randomNumber.value += 10;
      }

      saveTheSuccessLevel.add(level.value);

      // currentWord = wordList[indices[currentWordListIndex.value]];
      currentWord =
          wordList.elementAt(indices.elementAt(currentWordListIndex.value));

      //currentWord = wordList[currentWordListIndex.value];
      score.value = 0;
      timeLeft.value = totalTime;
      currentQuestionIndex.value = 0;
      revealedLetters.value = "-" * currentWord.word.length;
      isCorrect.clear();

      availableHint.value = 1;
      _randomHiddenWordIndex(currentWord.word.length);
      _generateEquations();
      _loadQuestion();
      //startTimer();
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
