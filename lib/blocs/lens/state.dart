part of 'bloc.dart';

class LensState extends Equatable {
  final List<String>? data;
  final String? analyticalData;
  final bool isSupercharged;
  final List<AgentMessage>? messages;
  final LensResponseState response;
  final SkillExtractionState skills;
  final KeywordsExtractionState keywords;
  final AnalyzePostState analyzeImage;
  final SuperchargeState superchargeState;

  const LensState({
    this.data,
    this.analyticalData,
    this.isSupercharged = false,
    this.messages,
    required this.response,
    required this.skills,
    required this.keywords,
    required this.analyzeImage,
    required this.superchargeState,
  });

  @override
  List<Object?> get props => [
        data,
        analyticalData,
        isSupercharged,
        messages,
        response,
        skills,
        keywords,
        analyzeImage,
        superchargeState,
      ];

  LensState copyWith({
    List<String>? data,
    String? analyticalData,
    bool? isSupercharged,
    List<AgentMessage>? messages,
    LensResponseState? response,
    SkillExtractionState? skills,
    KeywordsExtractionState? keywords,
    AnalyzePostState? analyzeImage,
    SuperchargeState? superchargeState,
  }) {
    return LensState(
      data: data ?? this.data,
      analyticalData: analyticalData ?? this.analyticalData,
      isSupercharged: isSupercharged ?? this.isSupercharged,
      messages: messages ?? this.messages,
      response: response ?? this.response,
      skills: skills ?? this.skills,
      keywords: keywords ?? this.keywords,
      analyzeImage: analyzeImage ?? this.analyzeImage,
      superchargeState: superchargeState ?? this.superchargeState,
    );
  }
}

class LensDefault extends LensState {
  const LensDefault()
      : super(
          data: null,
          analyticalData: null,
          isSupercharged: false,
          messages: null,
          response: const LensInitial(),
          skills: const SkillExtractionInitial(),
          keywords: const KeywordsExtractionInitial(),
          analyzeImage: const AnalyzePostInitial(),
          superchargeState: const SuperchargeInitial(),
        );
}
