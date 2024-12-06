part of '../bloc.dart';

final class SuperchargeState extends Equatable {
  final String? error;
  const SuperchargeState({
    this.error,
  });

  @override
  List<Object?> get props => [error];
}

final class SuperchargeInitial extends SuperchargeState {
  const SuperchargeInitial();
}

final class SuperchargeLoading extends SuperchargeState {
  const SuperchargeLoading();
}

final class SuperchargeSuccess extends SuperchargeState {
  const SuperchargeSuccess();
}

final class SuperchargeFailure extends SuperchargeState {
  const SuperchargeFailure({
    required String error,
  }) : super(error: error);
}
