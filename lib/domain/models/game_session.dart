import 'package:hive/hive.dart';

part 'game_session.g.dart';

@HiveType(typeId: 0)
class GameSession {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String userEmail;

  @HiveField(2)
  Duration duration;

  @HiveField(3)
  int correctAnwers;

  @HiveField(4)
  int level;

  GameSession({
    this.id,
    required this.userEmail,
    required this.duration,
    required this.correctAnwers,
    required this.level, // level of this session
  });

  factory GameSession.fromJson(Map<String, dynamic> json) => GameSession(
        id: json["id"],
        userEmail: json["user_email"] ?? "someEmail",
        duration: Duration(
            minutes: json["duration_minutes"] ?? 0,
            seconds: json["duration_seconds"] ?? 0),
        correctAnwers: json["correct_anwers"] ?? 0,
        level: json["level"] ?? "someDate",
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? 0,
        "user_email": userEmail,
        "duration_minutes": duration.inMinutes,
        "duration_seconds": duration.inSeconds,
        "correct_anwers": correctAnwers,
        "level": level,
      };
}
