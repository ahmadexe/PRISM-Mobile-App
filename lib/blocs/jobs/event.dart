part of 'bloc.dart';

sealed class JobsEvent extends Equatable {
  const JobsEvent();

  @override
  List<Object?> get props => [];
}

class CreateJob extends JobsEvent {
  final String title;
  final String description;
  final double budget;
  final String budgetMeta;
  final String country;
  final String postedBy;
  final String username;
  final String? avatar;
  final List<String> keywords;

  const CreateJob({
    required this.title,
    required this.description,
    required this.budget,
    required this.budgetMeta,
    required this.country,
    required this.postedBy,
    required this.username,
    required this.avatar,
    required this.keywords,
  });

  @override
  List<Object?> get props => [
        title,
        description,
        budget,
        budgetMeta,
        country,
        postedBy,
        username,
        avatar,
        keywords,
      ];
}

class FetchJobs extends JobsEvent {
  const FetchJobs();

  @override
  List<Object?> get props => [];
}

class LikeUnlikeJob extends JobsEvent {
  final String jobId;
  final String userId;

  const LikeUnlikeJob({
    required this.jobId,
    required this.userId,
  });

  @override
  List<Object?> get props => [jobId, userId];
}

class ApplyForJob extends JobsEvent {
  final String jobId;
  final String userId;

  const ApplyForJob({
    required this.jobId,
    required this.userId,
  });

  @override
  List<Object?> get props => [jobId, userId];
}
