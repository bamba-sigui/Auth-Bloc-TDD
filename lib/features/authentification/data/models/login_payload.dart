import 'dart:convert';

class LoginPayload {
  final String email;
  final String password;

  LoginPayload({required this.email, required this.password});

  factory LoginPayload.fromMap(Map<String, dynamic> json) {
    return LoginPayload(email: json['email'], password: json['password']);
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password
    };
  }

  String toJson() => json.encode(toMap());

  factory LoginPayload.fromJsom(String source) => LoginPayload.fromMap(json.decode(source));

}