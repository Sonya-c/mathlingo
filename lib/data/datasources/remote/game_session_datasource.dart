import 'dart:convert';
import 'package:loggy/loggy.dart';
import '../../../domain/models/game_session.dart';
import 'package:http/http.dart' as http;

class GameSessionDataSource {
  final String apiKey = 'IbOEmd';

  Future<List<GameSession>> getGameSessions(String email) async {
    List<GameSession> gameSessions = [];

    var request = Uri.parse("https://retoolapi.dev/$apiKey/data")
        .resolveUri(Uri(queryParameters: {
      "format": 'json',
      "user_email": email,
    }));

    var response = await http.get(request);

    if (response.statusCode == 200) {
      //logInfo(response.body);
      final data = jsonDecode(response.body);

      gameSessions =
          List<GameSession>.from(data.map((x) => GameSession.fromJson(x)));
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.error('Error code ${response.statusCode}');
    }

    return Future.value(gameSessions);
  }

  Future<bool> addGameSession(GameSession gameSession) async {
    logInfo("Web service, Adding GameSession");

    final response = await http.post(
      Uri.parse("https://retoolapi.dev/$apiKey/data"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(gameSession.toJson()),
    );

    if (response.statusCode == 201) {
      //logInfo(response.body);
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }

  Future<bool> simulateProcess(String baseUrl, String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/me"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );

    logInfo(response.statusCode);
    if (response.statusCode == 200) {
      logInfo('simulateProcess access ok');
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.error('Error code ${response.statusCode}');
    }
  }
}
