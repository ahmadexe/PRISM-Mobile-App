part of '../bloc.dart';

final class CreateJobState extends Equatable {
  static bool match(JobsState a, JobsState b) => a.create != b.create;

  final String? error;
  const CreateJobState({
    this.error,
  });

  @override
  List<Object?> get props => [error];
}

final class CreateJobInitial extends CreateJobState {
  const CreateJobInitial();
}

final class CreateJobLoading extends CreateJobState {
  const CreateJobLoading();
}

final class CreateJobSuccess extends CreateJobState {
  const CreateJobSuccess();
}

final class CreateJobFailure extends CreateJobState {
  const CreateJobFailure({
    required String error,
  }) : super(error: error);
}
