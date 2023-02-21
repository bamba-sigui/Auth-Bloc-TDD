class Welcome {
  Welcome({
    required this.token,
    required this.user,
  });

  final Token token;
  final User user;

  Welcome copyWith({
    Token? token,
    User? user,
  }) =>
      Welcome(
        token: token ?? this.token,
        user: user ?? this.user,
      );
}

class Token {
  Token({
    required this.type,
    required this.token,
    required this.expiresAt,
  });

  final String type;
  final String token;
  final DateTime expiresAt;

  Token copyWith({
    String? type,
    String? token,
    DateTime? expiresAt,
  }) =>
      Token(
        type: type ?? this.type,
        token: token ?? this.token,
        expiresAt: expiresAt ?? this.expiresAt,
      );
}

class User {
  User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.emailAddress,
    required this.createdAt,
    required this.updatedAt,
  });

  final int userId;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String emailAddress;
  final DateTime createdAt;
  final DateTime updatedAt;

  User copyWith({
    int? userId,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? emailAddress,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      User(
        userId: userId ?? this.userId,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        emailAddress: emailAddress ?? this.emailAddress,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
