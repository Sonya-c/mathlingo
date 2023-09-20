import 'package:get/get.dart';

import '../../domain/use_case/game_usecase.dart';
import '../../domain/repositories/game_repository.dart';

class GameController {
  final GameUseCase _gameUseCase = Get.find();

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
    return await _gameUseCase.levelUp();
  }

  Future<int> getLevel() async {
    return await _gameUseCase.getLevel();
  }
}
