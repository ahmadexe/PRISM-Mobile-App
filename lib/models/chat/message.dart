import 'dart:convert';

class Message {
  final String id;
  final DateTime createdAt;
  final String message;
  final String senderId;
  final String senderName;
  final String? senderPic;
  final String conversationId;
  final String receiverId;
  final String receiverName;
  final String? receiverPic;

  Message({
    required this.id,
    required this.createdAt,
    required this.message,
    required this.senderId,
    required this.senderName,
    this.senderPic,
    required this.conversationId,
    required this.receiverId,
    required this.receiverName,
    this.receiverPic,
  });

  Message copyWith({
    String? id,
    DateTime? createdAt,
    String? message,
    String? senderId,
    String? senderName,
    String? senderPic,
    String? conversationId,
    String? receiverId,
    String? receiverName,
    String? receiverPic,
  }) {
    return Message(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      message: message ?? this.message,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      senderPic: senderPic ?? this.senderPic,
      conversationId: conversationId ?? this.conversationId,
      receiverId: receiverId ?? this.receiverId,
      receiverName: receiverName ?? this.receiverName,
      receiverPic: receiverPic ?? this.receiverPic,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'message': message,
      'senderId': senderId,
      'senderName': senderName,
      'senderPic': senderPic,
      'conversationId': conversationId,
      'receiverId': receiverId,
      'receiverName': receiverName,
      'receiverPic': receiverPic,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      message: map['message'] as String,
      senderId: map['senderId'] as String,
      senderName: map['senderName'] as String,
      senderPic: map['senderPic'] != null ? map['senderPic'] as String : null,
      conversationId: map['conversationId'] as String,
      receiverId: map['receiverId'] as String,
      receiverName: map['receiverName'] as String,
      receiverPic:
          map['receiverPic'] != null ? map['receiverPic'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(id: $id, createdAt: $createdAt, message: $message, senderId: $senderId, senderName: $senderName, senderPic: $senderPic, conversationId: $conversationId, receiverId: $receiverId, receiverName: $receiverName, receiverPic: $receiverPic)';
  }

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.message == message &&
        other.senderId == senderId &&
        other.senderName == senderName &&
        other.senderPic == senderPic &&
        other.conversationId == conversationId &&
        other.receiverId == receiverId &&
        other.receiverName == receiverName &&
        other.receiverPic == receiverPic;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        message.hashCode ^
        senderId.hashCode ^
        senderName.hashCode ^
        senderPic.hashCode ^
        conversationId.hashCode ^
        receiverId.hashCode ^
        receiverName.hashCode ^
        receiverPic.hashCode;
  }
}
