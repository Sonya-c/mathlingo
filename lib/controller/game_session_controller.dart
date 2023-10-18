import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../domain/use_case/game_session_usecase.dart';
import '../domain/models/game_session.dart';

import 'package:connectivity/connectivity.dart';

class GameSessionController {
  final GameSessionUseCase _gameSessionUseCase = Get.find();
  var gameSessions = <GameSession>[].obs;

  Future<void> getGameSessions(String email) async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      // Offline: Retrieve game sessions from local storage
      gameSessions.value = await _gameSessionUseCase.getLocalGameSessionsByEmail(email);
    } else {
      // Online: Retrieve game sessions from the web service
      gameSessions.value = await _gameSessionUseCase.getGameSessions(email);
    }
  }

  Future<bool> addGameSession(GameSession gameSession) async =>
      await _gameSessionUseCase.addGameSession(gameSession);

  Future<List<GameSession>> getLocalGameSessionsByEmail(String email) async =>
      await _gameSessionUseCase.getLocalGameSessionsByEmail(email);

  Future<void> synchronizeGameSessions(GameSession currentSession) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      logInfo("You are OFFLINE");
      // Offline: Save the current game session locally
      await _gameSessionUseCase.insertLocalGameSession(currentSession);
    } else {
      logInfo("You are ONLINE");
      // Online: Check for local data and upload to web service
      List<GameSession> localSessions = await _gameSessionUseCase
          .getLocalGameSessionsByEmail(currentSession.userEmail);
      for (var session in localSessions) {
        bool success = await _gameSessionUseCase.addGameSession(session);
        if (success) {
          await _gameSessionUseCase
              .deleteLocalGameSessionByEmail(session.userEmail);
        }
      }
      // Add current game session
      await _gameSessionUseCase.addGameSession(currentSession);
    }
  }
}
