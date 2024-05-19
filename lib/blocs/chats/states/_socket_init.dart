part of '../bloc.dart';

class SocketInitState extends Equatable {
  static bool match(ChatsState a, ChatsState b) => a.socketInit != b.socketInit;

  final String? message;

  const SocketInitState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class SocketInitDefault extends SocketInitState {
  const SocketInitDefault();
}

class SocketInitLoading extends SocketInitState {
  const SocketInitLoading();
}

class SocketInitSuccess extends SocketInitState {
  const SocketInitSuccess();
}

class SocketInitFailure extends SocketInitState {
  const SocketInitFailure({
    required String message,
  }) : super(message: message);
}
