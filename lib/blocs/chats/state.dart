// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bloc.dart';

class ChatsState extends Equatable {
  final WebSocketChannel? channel;
  final List<Message>? messages;
  final List<Conversation>? convos;
  final Conversation? currentConvo;
  final String? error;
  final SocketInitState socketInit;
  final ConvoInitState convoInit;
  final SendMessageState send;
  final FetchAllConvosState fetchAllConvos;

  const ChatsState({
    this.channel,
    this.messages,
    this.convos,
    this.currentConvo,
    this.error,
    required this.socketInit,
    required this.convoInit,
    required this.send,
    required this.fetchAllConvos,
  });

  @override
  List<Object?> get props => [
        channel,
        messages,
        convos,
        currentConvo,
        error,
        convoInit,
        socketInit,
        send,
        fetchAllConvos,
      ];

  ChatsState copyWith({
    WebSocketChannel? channel,
    List<Message>? messages,
    List<Conversation>? convos,
    Conversation? currentConvo,
    String? error,
    SocketInitState? socketInit,
    ConvoInitState? convoInit,
    SendMessageState? send,
    FetchAllConvosState? fetchAllConvos,
  }) {
    return ChatsState(
      channel: channel ?? this.channel,
      messages: messages ?? this.messages,
      convos: convos ?? this.convos,
      currentConvo: currentConvo ?? this.currentConvo,
      error: error ?? this.error,
      socketInit: socketInit ?? this.socketInit,
      convoInit: convoInit ?? this.convoInit,
      send: send ?? this.send,
      fetchAllConvos: fetchAllConvos ?? this.fetchAllConvos,
    );
  }
}

class ChatsDefault extends ChatsState {
  const ChatsDefault()
      : super(
          channel: null,
          messages: null,
          convos: null,
          currentConvo: null,
          error: null,
          socketInit: const SocketInitDefault(),
          send: const SendMessageDefault(),
          convoInit: const ConvoInitDefault(),
          fetchAllConvos: const FetchAllConvosDefault(),
        );
}
