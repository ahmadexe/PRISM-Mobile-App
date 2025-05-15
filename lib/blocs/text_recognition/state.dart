part of 'bloc.dart';

sealed class TextRecognitionState extends Equatable {
  final String? text;
  final String? error;
  const TextRecognitionState({
    this.text,
    this.error,
  });

  @override
  List<Object> get props => [];
}

final class TextRecognitionInitial extends TextRecognitionState {
  const TextRecognitionInitial();
}

final class TextRecognitionLoading extends TextRecognitionState {
  const TextRecognitionLoading();
}

final class TextRecognitionSuccess extends TextRecognitionState {
  const TextRecognitionSuccess({
    required String text,
  }) : super(text: text);
}

final class TextRecognitionFailure extends TextRecognitionState {
  const TextRecognitionFailure({
    required String error,
  }) : super(error: error);
}
