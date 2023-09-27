class GameSession {
  int? id;
  String userEmail;
  Duration duration;
  int correctAnwers;
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
