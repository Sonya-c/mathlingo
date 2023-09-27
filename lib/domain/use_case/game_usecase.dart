import 'dart:math';

import 'package:loggy/loggy.dart';

import '../models/game_answers.dart';
import '../models/math_problem.dart';

class GameUseCase {
  late MathProblem _currentProblem;
  List<MathAnswer> mathAnswers = [];

  final _random = Random();
  int next(int min, int max) => min + _random.nextInt(max - min);

  int _level = 1;

  GameUseCase() {
    _currentProblem = _generateRandomProblem();
  }

  Future<MathProblem> generateProblem() async {
    _currentProblem = _generateRandomProblem();
    return _currentProblem;
  }

  Future<bool> verifyAnswer(int answer, Duration timeTaken) async {
    bool isCorrect = answer == _currentProblem.answer;
    mathAnswers.add(MathAnswer(_currentProblem, timeTaken, isCorrect));
    return isCorrect;
  }

  Future<int> getAnswer() async {
    return _currentProblem.answer;
  }

  Future<void> clearAnswers() async {
    mathAnswers = [];
  }

  Future<List<MathAnswer>> getAnswers() async {
    return mathAnswers;
  }

  Future<int> getLevel() async {
    return _level;
  }

  Future<void> setLevel(int level) async {
    _level = level;
  }

  Future<int> levelUp() async {
    int totalCorrectAnswers = 0;
    for (MathAnswer ans in mathAnswers) {
      if (ans.isCorrect) totalCorrectAnswers++;
    }

    if (totalCorrectAnswers > mathAnswers.length ~/ 2) {
      _level++;
      return 1;
    } else if (totalCorrectAnswers < mathAnswers.length ~/ 2) {
      // to level down it must be less (not equal)
      if (_level > 1) _level--;
      return -1;
    } else {
      return 0;
    }
  }

  MathProblem _generateRandomProblem() {
    var operations = ["+", "-", "*"];
    // _level = # digits * operation dificulty factor
    // selects a random operation
    // each operation have a dificulty factor
    // +: 1; -: 2; *: 3;
    String op = operations[next(0, _level <= 3 ? _level : 3)];

    int num1, num2, answer, digits;

    switch (op) {
      case "+": // dificulty factor = 1
        digits = _level ~/ 1;

        num1 = next(10 * (digits - 1), 10 * digits);
        num2 = next(10 * (digits - 1), 10 * digits);

        answer = num1 + num2;
        break;
      case "-": // dificulty factor = 2
        digits = _level ~/ 2;

        num1 = next(10 * (digits - 1), 10 * digits);
        num2 = next(10 * (digits - 1), 10 * digits);

        if (num1 < num2) {
          [num1, num2] = [num2, num1]; // lol, find a pythonic swap
          logInfo("swap");
        }
        answer = num1 - num2;
        break;
      case "*": // dificulty factor = 3
        digits = _level ~/ 3;

        num1 = next(10 * (digits - 1), 10 * digits);
        num2 = next(10 * (digits - 1), 10 * digits);

        answer = num1 * num2;
        break;
      default:
        throw Exception("Unknown operation");
    }

    return MathProblem(num1, num2, op, answer);
  }
}
