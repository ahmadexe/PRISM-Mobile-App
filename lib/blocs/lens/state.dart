part of 'bloc.dart';

class LensState extends Equatable {
  final List<LensMessage>? messages;
  final LensResponseState response;
  final SkillExtractionState skills;
  final KeywordsExtractionState keywords;
  const LensState({
    this.messages,
    required this.response,
    required this.skills,
    required this.keywords,
  });

  @override
  List<Object?> get props => [messages, response, skills, keywords];

  LensState copyWith({
    List<LensMessage>? messages,
    LensResponseState? response,
    SkillExtractionState? skills,
    KeywordsExtractionState? keywords,
  }) {
    return LensState(
      messages: messages ?? this.messages,
      response: response ?? this.response,
      skills: skills ?? this.skills,
      keywords: keywords ?? this.keywords,
    );
  }
}

class LensDefault extends LensState {
  const LensDefault()
      : super(
          messages: null,
          response: const LensInitial(),
          skills: const SkillExtractionInitial(),
          keywords: const KeywordsExtractionInitial(),
        );
}
