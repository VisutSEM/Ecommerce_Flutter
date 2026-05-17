class LoginReq {
  final String email;
  final String password;

  LoginReq({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
    };
  }

  factory LoginReq.fromJson(Map<String, dynamic> json) {
    return LoginReq(
      email: json['email'],
      password: json['password'],
    );
  }
}