part of '../bloc.dart';

final class ApplyForJobState extends Equatable {
  static bool match(JobsState a, JobsState b) => a.apply != b.apply;

  final String? error;
  const ApplyForJobState({
    this.error,
  });

  @override
  List<Object?> get props => [error];
}

final class ApplyForJobInitial extends ApplyForJobState {
  const ApplyForJobInitial();
}

final class ApplyForJobLoading extends ApplyForJobState {
  const ApplyForJobLoading();
}

final class ApplyForJobSuccess extends ApplyForJobState {
  const ApplyForJobSuccess();
}

final class ApplyForJobFailure extends ApplyForJobState {
  const ApplyForJobFailure({
    required String error,
  }) : super(error: error);
}
