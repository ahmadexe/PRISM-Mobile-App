part of '../bloc.dart';

class AuthUpdateState extends Equatable {
  static bool match(AuthState a, AuthState b) => a.update != b.update;

  final String? message;

  const AuthUpdateState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class AuthUpdateDefault extends AuthUpdateState {
  const AuthUpdateDefault();
}

class AuthUpdateLoading extends AuthUpdateState {
  const AuthUpdateLoading();
}

class AuthUpdateSuccess extends AuthUpdateState {
  const AuthUpdateSuccess();
}

class AuthUpdateFailure extends AuthUpdateState {
  const AuthUpdateFailure({
    required String message,
  }) : super(message: message);
}