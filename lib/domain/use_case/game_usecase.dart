import 'dart:math';

import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:mathlingo/domain/models/game_session.dart';

import '../models/game_answers.dart';
import '../models/math_problem.dart';

class GameUseCase {
  late MathProblem _currentProblem;
  List<MathAnswer> mathAnswers = [];

  final _random = Random();
  int next(int min, int max) => min + _random.nextInt(max - min);

  final level = 1.obs;

  GameUseCase() {
    init();
  }

  Future<void> init() async {
    _currentProblem = _generateRandomProblem();
    mathAnswers = [];
    level.value = 1;
  }

  Future<MathProblem> generateProblem() async {
    _currentProblem = _generateRandomProblem();
    return _currentProblem;
  }

  MathProblem _generateRandomProblem() {
    var operations = ["+", "-", "*"];
    // level = # digits * operation dificulty factor
    // selects a random operation
    // each operation have a dificulty factor
    // +: 1; -: 2; *: 3;
    String op = operations[next(0, level.value <= 3 ? level.value : 3)];

    int num1, num2, answer, digits;

    switch (op) {
      case "+": // dificulty factor = 1
        digits = level ~/ 1;

        num1 = next(10 * (digits - 1), 10 * digits);
        num2 = next(10 * (digits - 1), 10 * digits);

        answer = num1 + num2;
        break;
      case "-": // dificulty factor = 2
        digits = level ~/ 2;

        num1 = next(10 * (digits - 1), 10 * digits);
        num2 = next(10 * (digits - 1), 10 * digits);

        if (num1 < num2) {
          int temp = num1;
          num1 = num2;
          num2 = temp;
          logInfo("swap");
        }
        answer = num1 - num2;
        break;
      case "*": // dificulty factor = 3
        digits = level ~/ 3;

        num1 = next(10 * (digits - 1), 10 * digits);
        num2 = next(10 * (digits - 1), 10 * digits);

        answer = num1 * num2;
        break;
      default:
        throw Exception("Unknown operation");
    }

    return MathProblem(num1, num2, op, answer);
  }

  Future<bool> verifyAnswer(int answer, Duration timeTaken) async {
    bool isCorrect = answer == _currentProblem.answer;
    mathAnswers.add(MathAnswer(_currentProblem, timeTaken, isCorrect));
    return isCorrect;
  }

  Future<int> getAnswer() async {
    return _currentProblem.answer;
  }

  Future<List<MathAnswer>> getAnswers() async {
    return mathAnswers;
  }

  Future<void> clearAnswers() async {
    mathAnswers = [];
  }

  Future<int> levelUp() async {
    int totalCorrectAnswers = 0;
    for (MathAnswer ans in mathAnswers) {
      if (ans.isCorrect) totalCorrectAnswers++;
    }

    if (totalCorrectAnswers > 6) {
      level.value++;
      return 1;
    } else if (totalCorrectAnswers < 6) {
      // to level down it must be less (not equal)
      if (level > 1) level.value--;
      return -1;
    } else {
      return 0;
    }
  }

  Future<void> retriveLevel(GameSession gameSession) async {
    level.value = gameSession.level;

    if (gameSession.correctAnwers > 6) {
      level.value++;
    } else if (gameSession.correctAnwers < 6) {
      // to level down it must be less (not equal)
      if (level.value > 1) level.value--;
    }
  }
}
