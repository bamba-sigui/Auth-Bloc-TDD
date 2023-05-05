import 'dart:convert';

import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  AuthModel({
    required this.token,
    required this.user,
  });

  final TokenModel token;
  final UserModel user;

  AuthModel copyWith({
    TokenModel? token,
    UserModel? user,
  }) =>
      AuthModel(
        token: token ?? this.token,
        user: user ?? this.user,
      );
  @override
  List<Object?> get props => [token, user];
}





class TokenModel extends Equatable {
  const TokenModel({
    required this.type,
    required this.token,
    // required this.expiresAt,
  });

  final String type;
  final String token;
  // final DateTime expiresAt;

  TokenModel copyWith({
    String? type,
    String? token,
    // DateTime? expiresAt,
  }) =>
      TokenModel(
        type: type ?? this.type,
        token: token ?? this.token,
        // expiresAt: expiresAt ?? this.expiresAt,
      );

  factory TokenModel.fromMap(Map<String, dynamic> json) {
    return TokenModel(
        type: json['type'],
        token: json['token'],
        // expiresAt: json['expiresAt']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'token': token,
      // 'expiresAt': expiresAt
    };
  }

  String toJson() => json.encode(toMap());

  factory TokenModel.fromCache(String source) => TokenModel.fromMap(json.decode(source));

  @override
  List<Object?> get props => [type, token];
}






class UserModel extends Equatable{
  UserModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.emailAddress,
  });

  final int userId;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String emailAddress;

  UserModel copyWith({
    int? userId,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? emailAddress,
  }) =>
      UserModel(
        userId: userId ?? this.userId,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        emailAddress: emailAddress ?? this.emailAddress,
      );

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        emailAddress: json["emailAddress"],
        phoneNumber: json["phoneNumber"]);
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'emailAddress': emailAddress,
      'phoneNumber': phoneNumber
    };
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromCache(String source) => UserModel.fromMap(json.decode(source));

  @override
  List<Object?> get props => [userId, firstName, lastName, emailAddress, phoneNumber];
}
