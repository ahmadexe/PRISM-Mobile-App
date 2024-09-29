part of '../bloc.dart';

class TokenState extends Equatable {
  static bool match(AuthState a, AuthState b) => a.token != b.token;
  final String? message;

  const TokenState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class TokenDefault extends TokenState {
  const TokenDefault();
}

class TokenLoading extends TokenState {
  const TokenLoading();
}

class TokenSuccess extends TokenState {
  const TokenSuccess();
}

class TokenFailure extends TokenState {
  const TokenFailure({
    required String message,
  }) : super(message: message);
}
