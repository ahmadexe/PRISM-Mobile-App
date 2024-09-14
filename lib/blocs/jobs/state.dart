part of 'bloc.dart';

class JobsState extends Equatable {
  final List<Job>? jobs;
  final CreateJobState create;
  final FetchJobsState fetch;

  const JobsState({
    this.jobs,
    required this.create,
    required this.fetch,
  });

  @override
  List<Object?> get props => [create, fetch, jobs];

  JobsState copyWith({
    List<Job>? jobs,
    CreateJobState? create,
    FetchJobsState? fetch,
  }) {
    return JobsState(
      jobs: jobs,
      create: create ?? this.create,
      fetch: fetch ?? this.fetch,
    );
  }
}

final class JobsInitial extends JobsState {
  const JobsInitial()
      : super(
          create: const CreateJobInitial(),
          fetch: const FetchJobsInitial(),
        );
}
