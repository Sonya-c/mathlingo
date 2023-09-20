import '../repositories/game_repository.dart';

class GameUseCase {
  final GameRepository _gameRepository;
  GameUseCase(this._gameRepository);

  Future<MathProblem> generateProblem() async =>
      await _gameRepository.generateProblem();

  Future<bool> verifyAnswer(int answer, Duration timeTaken) async {
    return await _gameRepository.verifyAnswer(answer, timeTaken);
  }

  Future<int> getAnswer() async {
    return await _gameRepository.getAnswer();
  }

  Future<void> clearAnswers() async {
    return await _gameRepository.clearAnswers();
  }

  Future<List<MathAnswer>> getAnswers() async {
    return await _gameRepository.getAnswers();
  }
}
