part of 'bloc.dart';

class LensState extends Equatable {
  final List<LensMessage>? messages;
  final LensResponseState response;
  const LensState({
    this.messages,
    required this.response,
  });

  @override
  List<Object?> get props => [messages, response];

  LensState copyWith({
    List<LensMessage>? messages,
    LensResponseState? response,
  }) {
    return LensState(
      messages: messages ?? this.messages,
      response: response ?? this.response,
    );
  }
}

class LensDefault extends LensState {
  const LensDefault()
      : super(
          messages: null,
          response: const LensInitial(),
        );
}

final class LensResponseState extends Equatable {
  final String? error;
  const LensResponseState({
    this.error,
  });

  @override
  List<Object?> get props => [error];
}

final class LensInitial extends LensResponseState {
  const LensInitial();
}

final class LensLoading extends LensResponseState {
  const LensLoading();
}

final class LensSuccess extends LensResponseState {
  const LensSuccess();
}

final class LensFailure extends LensResponseState {
  const LensFailure({
    required String error,
  }) : super(error: error);
}
