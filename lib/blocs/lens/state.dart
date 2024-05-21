part of 'bloc.dart';

class LensState extends Equatable {
  final List<LensMessage>? messages;
  final LensResponseState response;
  final SkillExtractionState skills;
  const LensState({
    this.messages,
    required this.response,
    required this.skills,
  });

  @override
  List<Object?> get props => [messages, response, skills];

  LensState copyWith({
    List<LensMessage>? messages,
    LensResponseState? response,
    SkillExtractionState? skills,
  }) {
    return LensState(
      messages: messages ?? this.messages,
      response: response ?? this.response,
      skills: skills ?? this.skills,
    );
  }
}

class LensDefault extends LensState {
  const LensDefault()
      : super(
          messages: null,
          response: const LensInitial(),
          skills: const SkillExtractionInitial(),
        );
}
