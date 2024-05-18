part of '../bloc.dart';

class ConvoInitState extends Equatable {
  static bool match(ChatsState a, ChatsState b) => a.convoInit != b.convoInit;

  final String? message;

  const ConvoInitState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class ConvoInitDefault extends ConvoInitState {
  const ConvoInitDefault();
}

class ConvoInitLoading extends ConvoInitState {
  const ConvoInitLoading();
}

class ConvoInitSuccess extends ConvoInitState {
  const ConvoInitSuccess();
}

class ConvoInitFailure extends ConvoInitState {
  const ConvoInitFailure({
    required String message,
  }) : super(message: message);
}
