part of 'bloc.dart';

class JobsState extends Equatable {
  final List<Job>? jobs;
  final CreateJobState create;
  final FetchJobsState fetch;
  final LikeToggleState like;
  final ApplyForJobState apply;

  const JobsState({
    this.jobs,
    required this.create,
    required this.fetch,
    required this.like,
    required this.apply,
  });

  @override
  List<Object?> get props => [create, fetch, jobs, like, apply];

  JobsState copyWith({
    List<Job>? jobs,
    CreateJobState? create,
    FetchJobsState? fetch,
    LikeToggleState? like,
    ApplyForJobState? apply,
  }) {
    return JobsState(
      jobs: jobs ?? this.jobs,
      create: create ?? this.create,
      fetch: fetch ?? this.fetch,
      like: like ?? this.like,
      apply: apply ?? this.apply,
    );
  }
}

final class JobsInitial extends JobsState {
  const JobsInitial()
      : super(
          create: const CreateJobInitial(),
          fetch: const FetchJobsInitial(),
          like: const LikeToggleInitial(),
          apply: const ApplyForJobInitial(),
        );
}
