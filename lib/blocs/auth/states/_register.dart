part of '../bloc.dart';

class AuthRegisterState extends Equatable {
  static bool match(AuthState a, AuthState b) => a.register != b.register;

  final String? message;

  const AuthRegisterState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class AuthRegisterDefault extends AuthRegisterState {
  const AuthRegisterDefault();
}

class AuthRegisterLoading extends AuthRegisterState {
  const AuthRegisterLoading();
}

class AuthRegisterSuccess extends AuthRegisterState {
  const AuthRegisterSuccess();
}

class AuthRegisterFailure extends AuthRegisterState {
  const AuthRegisterFailure({
    required String message,
  }) : super(message: message);
}
