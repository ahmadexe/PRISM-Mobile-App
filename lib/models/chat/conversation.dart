import 'dart:convert';

class Conversation {
  final String id;
  final String user1Id;
  final String user2Id;
  final String user1Name;
  final String user2Name;
  final String? user1Pic;
  final String? user2Pic;

  Conversation({
    required this.id,
    required this.user1Id,
    required this.user2Id,
    required this.user1Name,
    required this.user2Name,
    this.user1Pic,
    this.user2Pic,
  });

  Conversation copyWith({
    String? id,
    String? user1Id,
    String? user2Id,
    String? user1Name,
    String? user2Name,
    String? user1Pic,
    String? user2Pic,
  }) {
    return Conversation(
      id: id ?? this.id,
      user1Id: user1Id ?? this.user1Id,
      user2Id: user2Id ?? this.user2Id,
      user1Name: user1Name ?? this.user1Name,
      user2Name: user2Name ?? this.user2Name,
      user1Pic: user1Pic ?? this.user1Pic,
      user2Pic: user2Pic ?? this.user2Pic,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user1Id': user1Id,
      'user2Id': user2Id,
      'user1Name': user1Name,
      'user2Name': user2Name,
      'user1Pic': user1Pic,
      'user2Pic': user2Pic,
    };
  }

  factory Conversation.fromMap(Map<String, dynamic> map) {
    return Conversation(
      id: map['id'] as String,
      user1Id: map['user1Id'] as String,
      user2Id: map['user2Id'] as String,
      user1Name: map['user1Name'] as String,
      user2Name: map['user2Name'] as String,
      user1Pic: map['user1Pic'] != null ? map['user1Pic'] as String : null,
      user2Pic: map['user2Pic'] != null ? map['user2Pic'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Conversation.fromJson(String source) =>
      Conversation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Conversation(id: $id, user1Id: $user1Id, user2Id: $user2Id, user1Name: $user1Name, user2Name: $user2Name, user1Pic: $user1Pic, user2Pic: $user2Pic)';
  }

  @override
  bool operator ==(covariant Conversation other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.user1Id == user1Id &&
        other.user2Id == user2Id &&
        other.user1Name == user1Name &&
        other.user2Name == user2Name &&
        other.user1Pic == user1Pic &&
        other.user2Pic == user2Pic;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user1Id.hashCode ^
        user2Id.hashCode ^
        user1Name.hashCode ^
        user2Name.hashCode ^
        user1Pic.hashCode ^
        user2Pic.hashCode;
  }
}
