class RegisterReq {
  final String name;
  final String email;
  final String password;

  RegisterReq({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
    };
  }
}