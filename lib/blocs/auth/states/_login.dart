part of '../bloc.dart';

class AuthLoginState extends Equatable {
  static bool match(AuthState a, AuthState b) => a.login != b.login;

  final String? message;

  const AuthLoginState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class AuthLoginDefault extends AuthLoginState {
  const AuthLoginDefault();
}

class AuthLoginLoading extends AuthLoginState {
  const AuthLoginLoading();
}

class AuthLoginSuccess extends AuthLoginState {
  const AuthLoginSuccess();
}

class AuthLoginFailure extends AuthLoginState {
  const AuthLoginFailure({
    required String message,
  }) : super(message: message);
}