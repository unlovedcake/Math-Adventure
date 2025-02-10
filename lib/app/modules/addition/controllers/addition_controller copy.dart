import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:math_adventure/app/data/model/word_model.dart';

class AdditionController extends GetxController {
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
    WordModel(
        word: "Albert Eistien",
        meaning: "Smart means having intelligence and quick thinking."),
    WordModel(
        word: "Nicola Testla",
        meaning: "Smart means having intelligence and quick thinking."),
    WordModel(
        word: "James Bron",
        meaning: "Smart means having intelligence and quick thinking."),
    WordModel(
        word: "Love Cake",
        meaning: "Smart means having intelligence and quick thinking."),
    WordModel(
        word: "Albert Eistien",
        meaning: "Smart means having intelligence and quick thinking."),
  ];

  final RxList<int> indices = <int>[].obs;

  final RxList<int> randomHiddenWordIndex = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    initializeRandomEquation();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  void initializeRandomEquation() {
    saveTheSuccessLevel.add(level.value);
    _randomTheIndexOfWordList();

    _randomHiddenWordIndex(currentWord.word.length);
    _generateEquations();

    _loadQuestion();

    revealedLetters.value = "-" * currentWord.word.length;
  }

  void _randomTheIndexOfWordList() {
    indices.value = List.generate(wordList.length, (index) => index);
    indices.shuffle(); // Shuffle the list of words
    currentWord = wordList[indices[currentWordListIndex.value]];
  }

  void _randomHiddenWordIndex(int wordLength) {
    randomHiddenWordIndex.value = List.generate(wordLength, (index) => index);
    randomHiddenWordIndex.shuffle(); // Shuffle the index of current word
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

      //scoreSet.add({'score': score.value, 'level': level.value});
      scoreSet[level.value - 1] = {
        ...scoreSet[level.value - 1], // Keep existing values
        'score': score.value, // Update only 'score'
      };

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
      // as long as there is equations not answer load next
      _loadQuestion();
    } else {
      //end game if all equations answered
      endGame(true);
    }
  }

  Random random = Random();
  void revealNextLetter() {
    if (score.value <= currentWord.word.length) {
      List<String> letters = revealedLetters.value.split('');

      // Reveal all instances of the next hidden letter
      String letterToReveal =
          currentWord.word[randomHiddenWordIndex[score.value - 1]];

      for (int i = 0; i < currentWord.word.length; i++) {
        if (currentWord.word[i].toLowerCase() == letterToReveal.toLowerCase()) {
          letters[i] = currentWord.word[i];
        }
      }

      if (score.value == 10) {
        revealedLetters.value = currentWord.word; // reveal full word
        endGame(true);
        return;
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
      lives.value = totalLives;
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
