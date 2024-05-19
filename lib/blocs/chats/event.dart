part of 'bloc.dart';

sealed class ChatsEvent extends Equatable {
  const ChatsEvent();

  @override
  List<Object> get props => [];
}

class SocketInit extends ChatsEvent {
  final String senderId;
  final String receiverId;
  const SocketInit({
    required this.senderId,
    required this.receiverId,
  });
}

class SubscribeToMessges extends ChatsEvent {
  const SubscribeToMessges();
}

class SendMessage extends ChatsEvent {
  final DateTime createdAt;
  final String message;
  final String senderId;
  final String receiverId;
  final String conversationId;
  final String senderName;
  final String receiverName;
  final String? senderImage;
  final String? receiverPic;

  const SendMessage({
    required this.createdAt,
    required this.message,
    required this.senderId,
    required this.receiverId,
    required this.conversationId,
    required this.senderName,
    required this.receiverName,
    this.senderImage,
    this.receiverPic,
  });
}

class ConvoInit extends ChatsEvent {
  final String user1Id;
  final String user2Id;
  final String user1Name;
  final String user2Name;
  final String? user1Pic;
  final String? user2Pic;

  const ConvoInit({
    required this.user1Id,
    required this.user2Id,
    required this.user1Name,
    required this.user2Name,
    this.user1Pic,
    this.user2Pic,
  });
}

class FetchAllConvos extends ChatsEvent {
  final String id;
  const FetchAllConvos({required this.id});
}

class CloseConvo extends ChatsEvent {
  const CloseConvo();
}