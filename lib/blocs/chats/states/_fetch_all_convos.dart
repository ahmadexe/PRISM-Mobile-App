part of '../bloc.dart';

class FetchAllConvosState extends Equatable {
  static bool match(ChatsState a, ChatsState b) =>
      a.fetchAllConvos != b.fetchAllConvos;

  final String? message;

  const FetchAllConvosState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class FetchAllConvosDefault extends FetchAllConvosState {
  const FetchAllConvosDefault();
}

class FetchAllConvosLoading extends FetchAllConvosState {
  const FetchAllConvosLoading();
}

class FetchAllConvosSuccess extends FetchAllConvosState {
  const FetchAllConvosSuccess();
}

class FetchAllConvosFailure extends FetchAllConvosState {
  const FetchAllConvosFailure({
    required String message,
  }) : super(message: message);
}
