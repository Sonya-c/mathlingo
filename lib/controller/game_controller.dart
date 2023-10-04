import 'package:get/get.dart';
import 'package:mathlingo/domain/models/game_session.dart';

import '../../domain/use_case/game_usecase.dart';
import '../domain/models/game_answers.dart';
import '../domain/models/math_problem.dart';

class GameController {
  final GameUseCase _gameUseCase = Get.find();

  get level => _gameUseCase.level;

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

  Future<void> clearState() async {
    return await _gameUseCase.init();
  }

  Future<void> retriveLevel(GameSession gameSession) async {
    return await _gameUseCase.retriveLevel(gameSession);
  }
}
