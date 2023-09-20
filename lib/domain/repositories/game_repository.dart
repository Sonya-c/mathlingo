import 'dart:math';

import 'package:loggy/loggy.dart';

class GameRepository {
  late MathProblem _currentProblem;
  List<MathAnswer> mathAnswers = [];

  final _random = Random();

  GameRepository() {
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

  MathProblem _generateRandomProblem() {
    var num1 = _random.nextInt(10); // generates a random integer from 0 to 9
    var num2 = _random.nextInt(10);
    var ops = ["+", "-", "*"];
    var op = ops[_random.nextInt(ops.length)]; // selects a random operation

    int answer;
    switch (op) {
      case "+":
        answer = num1 + num2;
        break;
      case "-":
        if (num1 < num2) {
          [num1, num2] = [num2, num1]; // lol, find a pythonic swap
          logInfo("swap");
        }
        answer = num1 - num2;
        break;
      case "*":
        answer = num1 * num2;
        break;
      default:
        throw Exception("Unknown operation");
    }

    return MathProblem(num1, num2, op, answer);
  }
}

class MathProblem {
  final int num1, num2, answer;
  final String op;

  MathProblem(this.num1, this.num2, this.op, this.answer);

  @override
  String toString() {
    return "$num1 $op $num2 = ";
  }
}

class MathAnswer {
  final MathProblem mathProblem;
  final Duration duration;
  final bool isCorrect;

  MathAnswer(this.mathProblem, this.duration, this.isCorrect);
}
