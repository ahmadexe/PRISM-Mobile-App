part of '../bloc.dart';

class FetchAllConvoState extends Equatable {
  static bool match(ChatsState a, ChatsState b) => a.fetchAllConvo != b.fetchAllConvo;

  final String? message;

  const FetchAllConvoState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class FetchAllConvoDefault extends FetchAllConvoState {
  const FetchAllConvoDefault();
}

class FetchAllConvoLoading extends FetchAllConvoState {
  const FetchAllConvoLoading();
}

class FetchAllConvoSuccess extends FetchAllConvoState {
  const FetchAllConvoSuccess();
}

class FetchAllConvoFailure extends FetchAllConvoState {
  const FetchAllConvoFailure({
    required String message,
  }) : super(message: message);
}
