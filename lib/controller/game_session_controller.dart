import 'package:get/get.dart';

import '../../domain/use_case/game_session_usecase.dart';
import '../domain/models/game_session.dart';

import 'package:connectivity/connectivity.dart';

class GameSessionController {
  final GameSessionUseCase _gameSessionUseCase = Get.find();

  Future<List<GameSession>> getGameSessions(String email) async =>
      await _gameSessionUseCase.getGameSessions(email);

  Future<bool> addGameSession(GameSession gameSession) async =>
      await _gameSessionUseCase.addGameSession(gameSession);

  Future<void> synchronizeGameSessions() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // Offline: Save game sessions locally
      // ... logic to save game sessions locally
    } else {
      // Online: Check for local data and upload to web service
      List<GameSession> localSessions = await _gameSessionUseCase.getAllLocalGameSessions();
      for (var session in localSessions) {
        bool success = await _gameSessionUseCase.addGameSession(session);
        if (success) {
          await _gameSessionUseCase.deleteLocalGameSession(session.id);
        }
      }
    }
  }
}
