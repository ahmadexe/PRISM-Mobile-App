part of '../bloc.dart';

sealed class KeywordsExtractionState extends Equatable {
  final List<String>? keywords;
  final String? error;
  const KeywordsExtractionState({
    this.keywords,
    this.error,
  });

  @override
  List<Object?> get props => [keywords, error];
}

final class KeywordsExtractionInitial extends KeywordsExtractionState {
  const KeywordsExtractionInitial();
}

final class KeywordsExtractionLoading extends KeywordsExtractionState {
  const KeywordsExtractionLoading();
}

final class KeywordsExtractionSuccess extends KeywordsExtractionState {
  const KeywordsExtractionSuccess({
    required List<String> keywords,
  }) : super(keywords: keywords);
}

final class KeywordsExtractionFailure extends KeywordsExtractionState {
  const KeywordsExtractionFailure({
    required String error,
  }) : super(error: error);
}
