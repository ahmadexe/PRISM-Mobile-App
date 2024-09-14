part of 'bloc.dart';

sealed class JobsEvent extends Equatable {
  const JobsEvent();

  @override
  List<Object> get props => [];
}

class CreateJob extends JobsEvent {
  final String title;
  final String description;
  final double budget;
  final String budgetMeta;
  final String country;

  const CreateJob({
    required this.title,
    required this.description,
    required this.budget,
    required this.budgetMeta,
    required this.country,
  });

  @override
  List<Object> get props => [
        title,
        description,
        budget,
        budgetMeta,
        country,
      ];
}
