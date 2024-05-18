import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prism/models/chat/conversation.dart';
import 'package:prism/models/chat/message.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'event.dart';
part 'state.dart';

part 'data_provider.dart';
part 'adaptor.dart';

part 'states/_socket_init.dart';
part 'states/_send_message.dart';
part 'states/_convo_init.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  late StreamSubscription chatstream;

  void closeChatStream() {
    chatstream.cancel();
  }

  ChatsBloc() : super(const ChatsDefault()) {
    on<ConvoInit>(_convoInit);
    on<SocketInit>(_initSocket);
    on<SubscribeToMessges>(_subscribeToMessges);
    on<SendMessage>(_sendMessage);
  }

  final _adaptor = _ChatsAdaptor();

  Future<void> _convoInit(ConvoInit event, Emitter<ChatsState> emit) async {
    emit(state.copyWith(
      convoInit: const ConvoInitLoading(),
    ));
    try {
      final convo = await _adaptor.initConvo(
        event.user1Id,
        event.user2Id,
        event.user1Name,
        event.user2Name,
        event.user1Pic,
        event.user2Pic,
      );
      emit(state.copyWith(
        convoInit: const ConvoInitSuccess(),
        messages: convo['messages'] as List<Message>,
        convo: convo['convo'] as Conversation,
      ));
    } catch (e) {
      emit(state.copyWith(
        convoInit: ConvoInitFailure(message: e.toString()),
      ));
    }
  }

  void _initSocket(SocketInit event, Emitter<ChatsState> emit) {
    emit(state.copyWith(
      socketInit: const SocketInitLoading(),
    ));
    try {
      final channel = _ChatsProvider.initChatChannel(
        event.senderId,
        event.receiverId,
      );
      emit(state.copyWith(
        channel: channel,
        socketInit: const SocketInitSuccess(),
      ));
    } catch (e) {
      emit(state.copyWith(
        socketInit: SocketInitFailure(message: e.toString()),
      ));
    }
  }

  _subscribeToMessges(
    SubscribeToMessges event,
    Emitter<ChatsState> emit,
  ) async {
    try {
      await emit.forEach(
        state.channel!.stream,
        onData: (data) {
          final json = data as Map<String, dynamic>;
          final message = Message.fromMap(json);
          return state.copyWith(
            messages: state.messages == null
                ? [message]
                : [...state.messages!, message],
          );
        },
      );
    } catch (e) {
      emit(state.copyWith(
        messages: [],
        error: e.toString(),
      ));
    }
  }

  void _sendMessage(
    SendMessage event,
    Emitter<ChatsState> emit,
  ) {
    emit(state.copyWith(
      send: const SendMessageLoading(),
    ));
    try {
      _adaptor.sendMessage(
        state.channel!,
        event.createdAt,
        event.message,
        event.senderId,
        event.receiverId,
        event.conversationId,
        event.senderName,
        event.receiverName,
        event.senderImage,
        event.receiverPic,
      );
      emit(state.copyWith(
        send: const SendMessageSuccess(),
      ));
    } catch (e) {
      emit(state.copyWith(
        send: SendMessageFailure(message: e.toString()),
      ));
    }
  }
}

