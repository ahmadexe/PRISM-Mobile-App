part of 'bloc.dart';

class JobsState extends Equatable {
  final CreateJobState create;
  const JobsState({
    required this.create,
  });

  @override
  List<Object> get props => [create];

  JobsState copyWith({
    CreateJobState? create,
  }) {
    return JobsState(
      create: create ?? this.create,
    );
  }
}

final class JobsInitial extends JobsState {
  const JobsInitial()
      : super(
          create: const CreateJobInitial(),
        );
}
