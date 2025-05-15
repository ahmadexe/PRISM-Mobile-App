part of '../bloc.dart';

final class FetchApplicationsState extends Equatable {
  static bool match(JobsState a, JobsState b) =>
      a.applications != b.applications;

  final String? error;
  final List<JobApplication>? applications;
  const FetchApplicationsState({
    this.error,
    this.applications,
  });

  @override
  List<Object?> get props => [error];
}

final class FetchApplicationsInitial extends FetchApplicationsState {
  const FetchApplicationsInitial();
}

final class FetchApplicationsLoading extends FetchApplicationsState {
  const FetchApplicationsLoading();
}

final class FetchApplicationsSuccess extends FetchApplicationsState {
  const FetchApplicationsSuccess({
    required List<JobApplication> applications,
  }) : super(applications: applications);
}

final class FetchApplicationsFailure extends FetchApplicationsState {
  const FetchApplicationsFailure({
    required String error,
  }) : super(error: error);
}
