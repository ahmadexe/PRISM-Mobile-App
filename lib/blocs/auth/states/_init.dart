part of '../bloc.dart';

class AuthInitState extends Equatable {
  static bool match(AuthState a, AuthState b) => a.init != b.init;

  final String? message;

  const AuthInitState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class AuthInitDefault extends AuthInitState {
  const AuthInitDefault();
}

class AuthInitLoading extends AuthInitState {
  const AuthInitLoading();
}

class AuthInitSuccess extends AuthInitState {
  const AuthInitSuccess();
}

class AuthInitFailure extends AuthInitState {
  const AuthInitFailure({
    required String message,
  }) : super(message: message);
}
