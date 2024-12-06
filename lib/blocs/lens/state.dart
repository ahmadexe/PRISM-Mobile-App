part of 'bloc.dart';

class LensState extends Equatable {
  final List<String>? data;

  final List<LensMessage>? messages;
  final LensResponseState response;
  final SkillExtractionState skills;
  final KeywordsExtractionState keywords;
  final AnalyzeImageState analyzeImage;

  const LensState({
    this.data,
    this.messages, 
    required this.response,
    required this.skills,
    required this.keywords,
    required this.analyzeImage,
  });

  @override
  List<Object?> get props => [data, messages, response, skills, keywords, analyzeImage];

  LensState copyWith({
    List<String>? data,
    List<LensMessage>? messages,
    LensResponseState? response,
    SkillExtractionState? skills,
    KeywordsExtractionState? keywords,
    AnalyzeImageState? analyzeImage,
  }) {
    return LensState(
      data: data ?? this.data,
      messages: messages ?? this.messages,
      response: response ?? this.response,
      skills: skills ?? this.skills,
      keywords: keywords ?? this.keywords,
      analyzeImage: analyzeImage ?? this.analyzeImage,
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
          analyzeImage: const AnalyzeImageInitial(),
        );
}
