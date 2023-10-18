import 'dart:ffi';

import 'package:get/get.dart';
import 'package:mathlingo/domain/models/game_session.dart';

import '../../domain/use_case/game_usecase.dart';
import '../domain/models/game_answers.dart';
import '../domain/models/math_problem.dart';

class GameController {
  final GameUseCase _gameUseCase = Get.find();

  final level = 1.obs;

  Future<MathProblem> generateProblem() async =>
      await _gameUseCase.generateProblem();

  Future<bool> verifyAnswer(int answer, Duration timeTaken) async {
    return await _gameUseCase.verifyAnswer(answer, timeTaken);
  }

  Future<int> getAnswer() async {
    return await _gameUseCase.getAnswer();
  }

  Future<void> clearAnswers() async {
    return await _gameUseCase.clearAnswers();
  }

  Future<List<MathAnswer>> getAnswers() async {
    return await _gameUseCase.getAnswers();
  }

  Future<int> levelUp() async {
    int levelup = await _gameUseCase.levelUp();
    level.value = _gameUseCase.level.value;
    return levelup;
  }

  Future<void> clearState() async {
    return await _gameUseCase.init();
  }

  Future<void> retriveLevel(GameSession gameSession) async {
    await _gameUseCase.retriveLevel(gameSession);
    level.value = _gameUseCase.level.value;
  }
}
