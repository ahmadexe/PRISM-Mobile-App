part of '../bloc.dart';

sealed class SkillExtractionState extends Equatable {
  final List<String>? skills;
  final String? error;
  const SkillExtractionState({
    this.skills,
    this.error,
  });

  @override
  List<Object> get props => [];
}

final class SkillExtractionInitial extends SkillExtractionState {
  const SkillExtractionInitial();
}

final class SkillExtractionLoading extends SkillExtractionState {
  const SkillExtractionLoading();
}

final class SkillExtractionSuccess extends SkillExtractionState {
  const SkillExtractionSuccess({
    required List<String> skills,
  }) : super(skills: skills);
}

final class SkillExtractionFailure extends SkillExtractionState {
  const SkillExtractionFailure({
    required String error,
  }) : super(error: error);
}
