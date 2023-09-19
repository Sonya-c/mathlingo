import 'dart:math';

class GameRepository {
  late MathProblem _currentProblem;
  final _random = Random();

  GameRepository() {
    _currentProblem = _generateRandomProblem();
  }

  Future<MathProblem> generateProblem() async {
    _currentProblem = _generateRandomProblem();
    return _currentProblem;
  }

  Future<bool> verifyAnswer(int answer, Duration timeTaken) async {
    return answer == _currentProblem.answer;
  }

  MathProblem _generateRandomProblem() {
    final num1 = _random.nextInt(10); // generates a random integer from 0 to 9
    final num2 = _random.nextInt(10);
    final ops = ["+", "-", "*"];
    final op = ops[_random.nextInt(ops.length)]; // selects a random operation

    int answer;
    switch(op) {
      case "+":
        answer = num1 + num2;
        break;
      case "-":
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
}