part of '../bloc.dart';

final class HireApplicantState extends Equatable {
  static bool match(JobsState a, JobsState b) => a.hire != b.hire;

  final String? error;
  const HireApplicantState({
    this.error,
  });

  @override
  List<Object?> get props => [error];
}

final class HireApplicantInitial extends HireApplicantState {
  const HireApplicantInitial();
}

final class HireApplicantLoading extends HireApplicantState {
  const HireApplicantLoading();
}

final class HireApplicantSuccess extends HireApplicantState {
  const HireApplicantSuccess();
}

final class HireApplicantFailure extends HireApplicantState {
  const HireApplicantFailure({
    required String error,
  }) : super(error: error);
}