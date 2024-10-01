import 'dart:convert';

class JobApplication {
  final String id;
  final String jobId;
  final String userId;
  final bool isHired;
  final String username;
  final String? avatar;

  JobApplication({
    required this.id,
    required this.jobId,
    required this.userId,
    required this.isHired,
    required this.username,
    this.avatar,
  });

  JobApplication copyWith({
    String? id,
    String? jobId,
    String? userId,
    bool? isHired,
    String? username,
    String? avatar,
  }) {
    return JobApplication(
      id: id ?? this.id,
      jobId: jobId ?? this.jobId,
      userId: userId ?? this.userId,
      isHired: isHired ?? this.isHired,
      username: username ?? this.username,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'jobId': jobId,
      'userId': userId,
      'isHired': isHired,
      'username': username,
      'avatar': avatar,
    };
  }

  factory JobApplication.fromMap(Map<String, dynamic> map) {
    return JobApplication(
      id: map['id'] as String,
      jobId: map['jobId'] as String,
      userId: map['userId'] as String,
      isHired: map['isHired'] as bool,
      username: map['username'] as String,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory JobApplication.fromJson(String source) => JobApplication.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'JobApplication(id: $id, jobId: $jobId, userId: $userId, isHired: $isHired, username: $username, avatar: $avatar)';
  }

  @override
  bool operator ==(covariant JobApplication other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.jobId == jobId &&
      other.userId == userId &&
      other.isHired == isHired &&
      other.username == username &&
      other.avatar == avatar;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      jobId.hashCode ^
      userId.hashCode ^
      isHired.hashCode ^
      username.hashCode ^
      avatar.hashCode;
  }
}
