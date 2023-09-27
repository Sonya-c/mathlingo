import 'package:mathlingo/data/datasources/remote/game_session_datasource.dart';
import '../models/game_session.dart';

class GameSessionRepository {
  late GameSessionDataSource _gameSessionDataSource;

  GameSessionRepository() {
    _gameSessionDataSource = GameSessionDataSource();
  }

  Future<List<GameSession>> getGameSessions(String email) async =>
      await _gameSessionDataSource.getGameSessions(email);

  Future<bool> addGameSession(GameSession gameSession) async =>
      await _gameSessionDataSource.addGameSession(gameSession);
}
