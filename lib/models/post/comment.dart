import 'dart:convert';

class Comment {
  final String id;
  final String userId;
  final String postId;
  final String userName;
  final String? userProfilePic;
  final String content;
  final DateTime createdAt; 

  Comment({
    required this.id,
    required this.userId,
    required this.postId,
    required this.userName,
    this.userProfilePic,
    required this.content,
    required this.createdAt,
  });

  Comment copyWith({
    String? id,
    String? userId,
    String? postId,
    String? userName,
    String? userProfilePic,
    String? content,
    DateTime? createdAt,
  }) {
    return Comment(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      postId: postId ?? this.postId,
      userName: userName ?? this.userName,
      userProfilePic: userProfilePic ?? this.userProfilePic,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'postId': postId,
      'userName': userName,
      'userProfilePic': userProfilePic,
      'content': content,
      'createdAt': createdAt.microsecondsSinceEpoch,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'] as String,
      userId: map['userId'] as String,
      postId: map['postId'] as String,
      userName: map['userName'] as String,
      userProfilePic: map['userProfilePic'] != null ? map['userProfilePic'] as String : null,
      content: map['content'] as String,
      createdAt: DateTime.fromMicrosecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) => Comment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Comment(id: $id, userId: $userId, postId: $postId, userName: $userName, userProfilePic: $userProfilePic, content: $content, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant Comment other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.userId == userId &&
      other.postId == postId &&
      other.userName == userName &&
      other.userProfilePic == userProfilePic &&
      other.content == content &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      userId.hashCode ^
      postId.hashCode ^
      userName.hashCode ^
      userProfilePic.hashCode ^
      content.hashCode ^
      createdAt.hashCode;
  }
}
