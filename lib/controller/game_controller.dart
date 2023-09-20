import '../../domain/use_case/game_usecase.dart';
import '../../domain/repositories/game_repository.dart';

class GameController {
  final GameUseCase _gameUseCase;
  GameController(this._gameUseCase);

  Future<MathProblem> generateProblem() async =>
      await _gameUseCase.generateProblem();

  Future<bool> verifyAnswer(int answer, Duration timeTaken) async {
    return await _gameUseCase.verifyAnswer(answer, timeTaken);
  }

  Future<int> getAnswer() async {
    return await _gameUseCase.getAnswer();
  }
}
