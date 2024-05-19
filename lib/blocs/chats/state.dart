// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bloc.dart';

class ChatsState extends Equatable {
  final WebSocketChannel? channel;
  final List<Message>? messages;
  final Conversation? convo;
  final String? error;
  final SocketInitState socketInit;
  final ConvoInitState convoInit;
  final SendMessageState send;
  final FetchAllConvoState fetchAllConvo;

  const ChatsState({
    this.channel,
    this.messages,
    this.convo,
    this.error,
    required this.socketInit,
    required this.convoInit,
    required this.send,
    required this.fetchAllConvo,
  });

  @override
  List<Object?> get props => [
        channel,
        messages,
        convo,
        error,
        convoInit,
        socketInit,
        send,
        fetchAllConvo,
      ];

  ChatsState copyWith({
    WebSocketChannel? channel,
    List<Message>? messages,
    Conversation? convo,
    String? error,
    SocketInitState? socketInit,
    ConvoInitState? convoInit,
    SendMessageState? send,
    FetchAllConvoState? fetchAllConvo,
  }) {
    return ChatsState(
      channel: channel ?? this.channel,
      messages: messages ?? this.messages,
      convo: convo ?? this.convo,
      error: error ?? this.error,
      socketInit: socketInit ?? this.socketInit,
      convoInit: convoInit ?? this.convoInit,
      send: send ?? this.send,
      fetchAllConvo: fetchAllConvo ?? this.fetchAllConvo,
    );
  }
}

class ChatsDefault extends ChatsState {
  const ChatsDefault()
      : super(
          channel: null,
          messages: null,
          convo: null,
          error: null,
          socketInit: const SocketInitDefault(),
          send: const SendMessageDefault(),
          convoInit: const ConvoInitDefault(),
          fetchAllConvo: const FetchAllConvoDefault(),
        );
}
