import 'package:mathlingo/data/datasources/remote/game_session_datasource.dart';
import 'package:mathlingo/data/datasources/local/game_session_local_datasource.dart';
import '../models/game_session.dart';

class GameSessionRepository {
  final GameSessionLocalDataSource _localDataSource = GameSessionLocalDataSource();
  late GameSessionDataSource _gameSessionDataSource;

  GameSessionRepository() {
    _gameSessionDataSource = GameSessionDataSource();
  }

  Future<List<GameSession>> getGameSessions(String email) async =>
      await _gameSessionDataSource.getGameSessions(email);

  Future<bool> addGameSession(GameSession gameSession) async =>
      await _gameSessionDataSource.addGameSession(gameSession);
  
  // Local methods 
  Future<void> insertLocalGameSession(GameSession session) async {
    await _localDataSource.insertGameSession(session);
  }

  Future<List<GameSession>> getAllLocalGameSessions() async {
    return _localDataSource.getAllGameSessions();
  }

  Future<void> deleteLocalGameSession(int? id) async {
    await _localDataSource.deleteGameSession(id);
  }
}
