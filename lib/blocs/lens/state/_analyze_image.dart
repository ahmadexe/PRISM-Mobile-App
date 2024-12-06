part of '../bloc.dart';

final class AnalyzeImageState extends Equatable {
  static bool match(LensState a, LensState b) =>
      a.analyzeImage != b.analyzeImage;
  final String? error;
  const AnalyzeImageState({
    this.error,
  });

  @override
  List<Object?> get props => [error];
}

final class AnalyzeImageInitial extends AnalyzeImageState {
  const AnalyzeImageInitial();
}

final class AnalyzeImageLoading extends AnalyzeImageState {
  const AnalyzeImageLoading();
}

final class AnalyzeImageSuccess extends AnalyzeImageState {
  const AnalyzeImageSuccess();
}

final class AnalyzeImageFailure extends AnalyzeImageState {
  const AnalyzeImageFailure({
    required String error,
  }) : super(error: error);
}
