part of '../bloc.dart';

class AuthLogoutState extends Equatable {
  static bool match(AuthState a, AuthState b) => a.logout != b.logout;

  final String? message;

  const AuthLogoutState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class AuthLogoutDefault extends AuthLogoutState {
  const AuthLogoutDefault();
}

class AuthLogoutLoading extends AuthLogoutState {
  const AuthLogoutLoading();
}

class AuthLogoutSuccess extends AuthLogoutState {
  const AuthLogoutSuccess();
}

class AuthLogoutFailure extends AuthLogoutState {
  const AuthLogoutFailure({
    required String message,
  }) : super(message: message);
}