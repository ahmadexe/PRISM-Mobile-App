part of '../bloc.dart';

class SendMessageState extends Equatable {
  static bool match(ChatsState a, ChatsState b) => a.send != b.send;

  final String? message;

  const SendMessageState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class SendMessageDefault extends SendMessageState {
  const SendMessageDefault();
}

class SendMessageLoading extends SendMessageState {
  const SendMessageLoading();
}

class SendMessageSuccess extends SendMessageState {
  const SendMessageSuccess();
}

class SendMessageFailure extends SendMessageState {
  const SendMessageFailure({
    required String message,
  }) : super(message: message);
}
