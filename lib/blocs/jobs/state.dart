part of 'bloc.dart';

class JobsState extends Equatable {
  final List<Job>? jobs;
  final CreateJobState create;
  final FetchJobsState fetch;
  final LikeToggleState like;

  const JobsState({
    this.jobs,
    required this.create,
    required this.fetch,
    required this.like,
  });

  @override
  List<Object?> get props => [create, fetch, jobs, like];

  JobsState copyWith({
    List<Job>? jobs,
    CreateJobState? create,
    FetchJobsState? fetch,
    LikeToggleState? like,
  }) {
    return JobsState(
      jobs: jobs ?? this.jobs,
      create: create ?? this.create,
      fetch: fetch ?? this.fetch,
      like: like ?? this.like,
    );
  }
}

final class JobsInitial extends JobsState {
  const JobsInitial()
      : super(
          create: const CreateJobInitial(),
          fetch: const FetchJobsInitial(),
          like: const LikeToggleInitial(),
        );
}
