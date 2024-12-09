part of '../bloc.dart';

class SuperchargeState extends Equatable {
  static bool match(AuthState a, AuthState b) => a.supercharge != b.supercharge;
  final String? message;

  const SuperchargeState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class SuperchargeDefault extends SuperchargeState {
  const SuperchargeDefault();
}

class SuperchargeLoading extends SuperchargeState {
  const SuperchargeLoading();
}

class SuperchargeSuccess extends SuperchargeState {
  const SuperchargeSuccess();
}

class SuperchargeFailure extends SuperchargeState {
  const SuperchargeFailure({
    required String message,
  }) : super(message: message);
}
