part of '../bloc.dart';

final class FetchMyJobsState extends Equatable {
  static bool match(JobsState a, JobsState b) => a.myJobs != b.myJobs;

  final String? error;
  final List<Job>? jobs;
  const FetchMyJobsState({
    this.error,
    this.jobs,
  });

  @override
  List<Object?> get props => [error];
}

final class FetchMyJobsInitial extends FetchMyJobsState {
  const FetchMyJobsInitial();
}

final class FetchMyJobsLoading extends FetchMyJobsState {
  const FetchMyJobsLoading();
}

final class FetchMyJobsSuccess extends FetchMyJobsState {
  const FetchMyJobsSuccess({
    required List<Job> jobs,
  }) : super(jobs: jobs);
}

final class FetchMyJobsFailure extends FetchMyJobsState {
  const FetchMyJobsFailure({
    required String error,
  }) : super(error: error);
}
