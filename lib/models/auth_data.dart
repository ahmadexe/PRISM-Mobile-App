import 'dart:convert';

class AuthData {
  final String email;
  final String domain;
  final String fullname;
  final String uid;
  final String id;
  final DateTime createdAt;

  AuthData({
    required this.email,
    required this.domain,
    required this.fullname,
    required this.uid,
    required this.id,
    required this.createdAt,
  });

  AuthData copyWith({
    String? email,
    String? domain,
    String? fullname,
    String? uid,
    String? id,
    DateTime? createdAt,
  }) {
    return AuthData(
      email: email ?? this.email,
      domain: domain ?? this.domain,
      fullname: fullname ?? this.fullname,
      uid: uid ?? this.uid,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'domain': domain,
      'fullname': fullname,
      'uid': uid,
      'id': id,
      'createdAt': createdAt.microsecondsSinceEpoch,
    };
  }

  factory AuthData.fromMap(Map<String, dynamic> map) {
    return AuthData(
      email: map['email'] as String,
      domain: map['domain'] as String,
      fullname: map['fullname'] as String,
      uid: map['uid'] as String,
      id: map['id'] as String,
      createdAt: DateTime.fromMicrosecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthData.fromJson(String source) => AuthData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AuthData(email: $email, domain: $domain, fullname: $fullname, uid: $uid, id: $id, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant AuthData other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.domain == domain &&
      other.fullname == fullname &&
      other.uid == uid &&
      other.id == id &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return email.hashCode ^
      domain.hashCode ^
      fullname.hashCode ^
      uid.hashCode ^
      id.hashCode ^
      createdAt.hashCode;
  }
}
