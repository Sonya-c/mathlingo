class User {
  User({
    this.id,
    required this.email,
    this.school,
    this.grade,
    this.dateString,
    
  });

  int? id;
  String email;
  String? school;
  int? grade;
  String? dateString;

  String get emailAddress => email;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"] ?? "someEmail",
        school: json["school"] ?? "someSchool",
        grade: json["grade"] ?? 0,
        dateString: json["date"] ?? "someDate",
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? 0,
        "email": email,
        "school": school ?? "someSchool",
        "grade": grade ?? 0,
        "date": dateString ?? "someDate",
      };
}
