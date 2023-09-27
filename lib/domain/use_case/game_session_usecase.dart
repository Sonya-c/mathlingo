import 'package:get/get.dart';
import 'package:mathlingo/domain/repositories/game_session_repository.dart';

import '../models/game_session.dart';

class GameSessionUseCase {
  final GameSessionRepository _gameSessionRepository = Get.find();

  Future<List<GameSession>> getGameSessions(String email) async =>
      await _gameSessionRepository.getGameSessions(email);

  Future<bool> addGameSession(GameSession gameSession) async =>
      await _gameSessionRepository.addGameSession(gameSession);
}
