class UserModel {
  String name;
  String email;
  String password;
  String createdAt;

  UserModel(
      {required this.createdAt,
      required this.email,
      required this.name,
      required this.password});

  factory UserModel.fromDoc(Map<String, dynamic> json) {
    return UserModel(
        createdAt: json["createdAt"],
        email: json["email"],
        name: json["name"],
        password: json["password"]);
  }

  Map<String, dynamic> toDoc() {
    return {
      "createdAt": createdAt,
      "email": email,
      "name": name,
      "password": password,
    };
  }
}
