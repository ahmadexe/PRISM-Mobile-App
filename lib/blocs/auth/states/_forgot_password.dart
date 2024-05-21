part of '../bloc.dart';

class ForgotPasswordState extends Equatable {
  static bool match(AuthState a, AuthState b) => a.forgot != b.forgot;
  final String? message;

  const ForgotPasswordState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class ForgotPasswordDefault extends ForgotPasswordState {
  const ForgotPasswordDefault();
}

class ForgotPasswordLoading extends ForgotPasswordState {
  const ForgotPasswordLoading();
}

class ForgotPasswordSuccess extends ForgotPasswordState {
  const ForgotPasswordSuccess();
}

class ForgotPasswordFailure extends ForgotPasswordState {
  const ForgotPasswordFailure({
    required String message,
  }) : super(message: message);
}
