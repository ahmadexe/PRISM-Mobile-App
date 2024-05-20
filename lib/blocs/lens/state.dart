part of 'bloc.dart';

sealed class LensState extends Equatable {
  final String? error;
  final String? content;
  const LensState({
    this.error,
    this.content,
  });
  
  @override
  List<Object?> get props => [error, content];
}

final class LensInitial extends LensState {
  const LensInitial();
}

final class LensLoading extends LensState {
  const LensLoading();
}

final class LensSuccess extends LensState {
  const LensSuccess({
    required String content,
  }) : super(content: content);
}

final class LensFailure extends LensState {
  const LensFailure({
    required String error,
  });
}
