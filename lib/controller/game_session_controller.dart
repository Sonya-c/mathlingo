import 'package:get/get.dart';

import '../../domain/use_case/game_session_usecase.dart';
import '../domain/models/game_session.dart';

class GameSessionController {
  final GameSessionUseCase _gameSessionUseCase = Get.find();

  Future<List<GameSession>> getGameSessions(String email) async =>
      await _gameSessionUseCase.getGameSessions(email);

  Future<bool> addGameSession(GameSession gameSession) async =>
      await _gameSessionUseCase.addGameSession(gameSession);
}
