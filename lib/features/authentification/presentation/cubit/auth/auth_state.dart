part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class GetLocalInProgress extends AuthState {
  @override
  List<Object> get props => [];
}

class GetLocalSuccess extends AuthState {
  final UserModel user;
  const GetLocalSuccess({required this.user});
  @override
  List<Object> get props => [user];
}

class GetLocalFailure extends AuthState {
  @override
  List<Object> get props => [];
}

class LoginInProgress extends AuthState {
  @override
  List<Object> get props => [];
}

class LoginFailure extends AuthState {
  final String message;
  const LoginFailure({required this.message});
  @override
  List<Object> get props => [message];
}

class LoginSuccess extends AuthState {
  final UserModel user;
  const LoginSuccess({required this.user});
  @override
  List<Object> get props => [user];
}