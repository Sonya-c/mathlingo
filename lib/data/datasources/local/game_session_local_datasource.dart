import 'package:hive/hive.dart';
import 'package:mathlingo/domain/models/game_session.dart';

class GameSessionLocalDataSource {
  Box<GameSession>? _box;

  Future<Box<GameSession>> get box async {
    if (_box == null || !_box!.isOpen) {
      _box = await Hive.openBox<GameSession>('game_sessions');
    }
    return _box!;
  }

  Future<void> insertGameSession(GameSession session) async {
  final box = await this.box;
  session.id ??= box.length + 1;
    await box.put(session.id, session);
  }

  Future<void> deleteGameSession(int? id) async {
  final box = await this.box;
    await box.delete(id);
  }

  Future<void> deleteGameSessionByEmail(String email) async {
  final box = await this.box;
    var keysToDelete = [];

    // Iterate through all stored game sessions to find matching email
    for (var key in box.keys) {
      var session = box.get(key);
      if (session?.userEmail == email) {
        keysToDelete.add(key);
      }
    }

    // Delete the sessions with the matching email
    for (var key in keysToDelete) {
      await box.delete(key);
    }
  }
  
  Future<List<GameSession>> getGameSessionsByEmail(String email) async {
  final box = await this.box;
    List<GameSession> matchingSessions = [];

    // Iterate through all stored game sessions to find matching userEmail
    for (var session in box.values) {
      if (session.userEmail == email) {
        matchingSessions.add(session);
      }
    }

    return matchingSessions;
  }
}
