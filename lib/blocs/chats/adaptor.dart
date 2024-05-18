part of 'bloc.dart';

class _ChatsAdaptor {
  void sendMessage(
  WebSocketChannel channel,
  DateTime createdAt,
  String message,
  String senderId,
  String receiverId,
  String conversationId,
  String senderName,
  String receiverName,
  String? senderImage,
  String? receiverPic,
  ) {
    final payload = {
      'createdAt': createdAt.millisecondsSinceEpoch,
      'message': message,
      'senderId': senderId,
      'receiverId': receiverId,
      'conversationId': conversationId,
      'senderName': senderName,
      'receiverName': receiverName,
      'senderImage': senderImage,
      'receiverPic': receiverPic,
    };
    _ChatsProvider.sendMessage(channel, payload);
  }

  Future<Map<String, dynamic>> initConvo(
    String user1Id,
    String user2Id,
    String user1Name,
    String user2Name,
    String? user1Pic,
    String? user2Pic,
  ) async {
    final payload = {
      'user1Id': user1Id,
      'user2Id': user2Id,
      'user1Name': user1Name,
      'user2Name': user2Name,
      'user1Pic': user1Pic,
      'user2Pic': user2Pic,
    };
    return _ChatsProvider.initConvo(payload);
  }
}