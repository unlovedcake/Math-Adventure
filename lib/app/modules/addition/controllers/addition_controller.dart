import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:math_adventure/app/data/model/word_model.dart';

class AdditionController extends GetxController {
  final int totalLives = 3;
  final int totalEquations = 5;
  final int totalTime = 180; // 3 minutes (180 seconds)

  final RxInt level = 1.obs;
  var lives = 3.obs;
  var score = 0.obs;
  var revealedLetters = ''.obs;
  var timeLeft = 180.obs;
  var currentQuestionIndex = 0.obs;
  var currentEquation = ''.obs;
  var correctAnswer = 0.obs;
  var choices = <int>[].obs;
  var isGameOver = false.obs;

  var randomNumber = 10.obs;

  final currentWordListIndex = 0.obs;
  final isCorrect = <bool>[].obs;

  final availableHint = 1.obs;

  Timer? _timer;
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
    _randomTheIndexOfWordList();

    _randomHiddenWordIndex(currentWord.word.length);
    _generateEquations();
    _startTimer();
    _loadQuestion();

    revealedLetters.value = "-" * currentWord.word.length;
    super.onInit();
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

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft.value > 0) {
        timeLeft.value--;
      } else {
        _endGame(false);
      }
    });
  }

  void _loadQuestion() {
    if (currentQuestionIndex.value < equations.length) {
      currentEquation.value = equations[currentQuestionIndex.value]["question"];
      correctAnswer.value = equations[currentQuestionIndex.value]["answer"];
      _generateChoices();
    } else {
      _endGame(true);
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
      _endGame(false);
      return;
    }

    currentQuestionIndex.value++;
    if (currentQuestionIndex.value < equations.length) {
      _loadQuestion();
    } else {
      _endGame(true);
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

      print('JPY ${randomHiddenWordIndex}');

      for (int i = 0; i < currentWord.word.length; i++) {
        if (currentWord.word[i].toLowerCase() == letterToReveal.toLowerCase()) {
          letters[i] = currentWord.word[i];
        }
      }

      print('JPYS ${score.value}');

      if (score.value == 5) {
        currentWord = wordList[indices[currentWordListIndex.value]];

        revealedLetters.value = currentWord.word;
      } else {
        revealedLetters.value = letters.join('');
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
    }
    availableHint.value = 0;
  }

  void _endGame(bool completed) {
    _timer?.cancel();

    completed
        ? Get.defaultDialog(
            barrierDismissible: false,
            title: "Level ${level.value} Completed!",
            content: Stack(
              alignment: Alignment.center,
              children: [
                Lottie.asset(
                  'assets/lottie/fireworks.json',
                  fit: BoxFit.cover,
                ),
                Column(
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
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                revealedLetters.value[index],
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
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
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Get.back();
                            _restartGame();
                          },
                          child: Text("Restart"),
                        ),
                        SizedBox(width: 10),
                        Obx(() => ElevatedButton(
                              onPressed: () {
                                if (level.value == 5) {
                                  Get.back();
                                  congrats();
                                } else {
                                  Get.back();
                                  nextLevel();
                                }
                              },
                              child: Text(
                                  level.value == 5 ? "Continue" : "Next Level"),
                            )),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        : Get.defaultDialog(
            barrierDismissible: false,
            title: lives.value == 0 ? "Out of lives" : 'Ran out of time',
            content: Column(
              children: [
                Lottie.asset(
                  'assets/lottie/game_over.json',
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            textConfirm: "Restart",
            onConfirm: () {
              Get.back();
              _restartGame();
            },
          );
  }

  void congrats() {
    Get.defaultDialog(
      barrierDismissible: false,
      title: 'Congratulation',
      content: Stack(
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
      textConfirm: "Close",
      onConfirm: () {
        Get.back();
        currentWordListIndex.value = 0;
        _restartGame();
      },
    );
  }

  void _restartGame() {
    currentQuestionIndex.value = 0;

    lives.value = totalLives;
    level.value = 1;
    score.value = 0;
    timeLeft.value = totalTime;

    isGameOver.value = false;
    availableHint.value = 1;
    randomNumber.value = 10;

    isCorrect.clear();
    indices.clear();
    _randomHiddenWordIndex(currentWord.word.length);
    _randomTheIndexOfWordList();
    currentWord = wordList[indices[currentWordListIndex.value]];
    revealedLetters.value = "-" * currentWord.word.length;
    _generateEquations();
    _loadQuestion();
    _startTimer();
  }

  void nextLevel() {
    if (level.value != 5) {
      currentWordListIndex.value++;
      level.value++;
      randomNumber.value += 10;
    }

    currentWord = wordList[indices[currentWordListIndex.value]];
    //currentWord = wordList[currentWordListIndex.value];
    score.value = 0;
    timeLeft.value = totalTime;
    currentQuestionIndex.value = 0;
    revealedLetters.value = "-" * currentWord.word.length;
    isCorrect.clear();
    isGameOver.value = false;
    availableHint.value = 1;
    _randomHiddenWordIndex(currentWord.word.length);
    _generateEquations();
    _loadQuestion();
    _startTimer();
  }
}
