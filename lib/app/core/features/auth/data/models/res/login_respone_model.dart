class LoginResponseModel {
  final String message;
  final UserData data;
  final String token;

  LoginResponseModel({
    required this.message,
    required this.data,
    required this.token,
  });
}

class UserData {
  final int id;
  final String name;
  final String email;

  UserData({
    required this.id,
    required this.name,
    required this.email,
  });
}