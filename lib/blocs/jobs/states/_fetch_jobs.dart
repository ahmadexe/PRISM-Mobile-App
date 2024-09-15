part of '../bloc.dart';

final class FetchJobsState extends Equatable {
  static bool match(JobsState a, JobsState b) => a.fetch != b.fetch;

  final String? error;
  const FetchJobsState({
    this.error,
  });

  @override
  List<Object?> get props => [error];
}

final class FetchJobsInitial extends FetchJobsState {
  const FetchJobsInitial();
}

final class FetchJobsLoading extends FetchJobsState {
  const FetchJobsLoading();
}

final class FetchJobsSuccess extends FetchJobsState {
  const FetchJobsSuccess();
}

final class FetchJobsFailure extends FetchJobsState {
  const FetchJobsFailure({
    required String error,
  }) : super(error: error);
}
