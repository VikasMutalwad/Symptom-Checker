class User {
  int? age;
  String? gender;
  String? duration;

  User({this.age, this.gender, this.duration});

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'gender': gender,
      'duration': duration,
    };
  }
}