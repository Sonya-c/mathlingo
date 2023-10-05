import 'package:hive/hive.dart';
import 'package:mathlingo/domain/models/game_session.dart';

class GameSessionLocalDataSource {
  final Box<GameSession> _box = Hive.box('game_sessions');

  Future<void> insertGameSession(GameSession session) async {
    await _box.put(session.id, session);
  }

  Future<List<GameSession>> getAllGameSessions() async {
    return _box.values.toList();
  }

  Future<void> deleteGameSession(int? id) async {
    await _box.delete(id);
  }

  // Add more methods as needed
}
