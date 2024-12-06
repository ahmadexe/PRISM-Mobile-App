part of '../bloc.dart';

final class AnalyzePostState extends Equatable {
  static bool match(LensState a, LensState b) =>
      a.analyzeImage != b.analyzeImage;
  final String? error;
  const AnalyzePostState({
    this.error,
  });

  @override
  List<Object?> get props => [error];
}

final class AnalyzePostInitial extends AnalyzePostState {
  const AnalyzePostInitial();
}

final class AnalyzePostLoading extends AnalyzePostState {
  const AnalyzePostLoading();
}

final class AnalyzePostSuccess extends AnalyzePostState {
  const AnalyzePostSuccess();
}

final class AnalyzePostFailure extends AnalyzePostState {
  const AnalyzePostFailure({
    required String error,
  }) : super(error: error);
}
