import 'dart:convert';

import 'package:flutter/foundation.dart';

class AuthData {
  final String email;
  final String domain;
  final String fullname;
  final String uid;
  final String id;
  final DateTime createdAt;
  final String bio;
  final String? imageUrl;
  final String? bannerImageUrl;
  final List<String> followers;
  final List<String> following;
  final bool isRanked;
  final bool isBusinessAcc;
  final bool isServiceProvider;
  final String deviceToken;
  final bool isSupercharged;
  final bool isSharingData;

  AuthData({
    required this.email,
    required this.domain,
    required this.fullname,
    required this.uid,
    required this.id,
    required this.createdAt,
    required this.bio,
    this.imageUrl,
    this.bannerImageUrl,
    this.followers = const [],
    this.following = const [],
    required this.isBusinessAcc,
    required this.isServiceProvider,
    required this.isRanked,
    required this.deviceToken,
    required this.isSupercharged,
    required this.isSharingData,
  });

  AuthData copyWith({
    String? email,
    String? domain,
    String? fullname,
    String? uid,
    String? id,
    DateTime? createdAt,
    String? bio,
    String? imageUrl,
    String? bannerImageUrl,
    List<String>? followers,
    List<String>? following,
    bool? isBusinessAcc,
    bool? isServiceProvider,
    bool? isRanked,
    String? deviceToken,
    bool? isSupercharged,
    bool? isSharingData,
  }) {
    return AuthData(
      email: email ?? this.email,
      domain: domain ?? this.domain,
      fullname: fullname ?? this.fullname,
      uid: uid ?? this.uid,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      bio: bio ?? this.bio,
      imageUrl: imageUrl ?? this.imageUrl,
      bannerImageUrl: bannerImageUrl ?? this.bannerImageUrl,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      isBusinessAcc: isBusinessAcc ?? this.isBusinessAcc,
      isServiceProvider: isServiceProvider ?? this.isServiceProvider,
      isRanked: isRanked ?? this.isRanked,
      deviceToken: deviceToken ?? this.deviceToken,
      isSupercharged: isSupercharged ?? this.isSupercharged,
      isSharingData: isSharingData ?? this.isSharingData,
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
      'bio': bio,
      'imageUrl': imageUrl,
      'bannerImageUrl': bannerImageUrl,
      'followers': followers,
      'following': following,
      'isBusinessAcc': isBusinessAcc,
      'isServiceProvider': isServiceProvider,
      'isRanked': isRanked,
      'deviceToken': deviceToken,
      'isSupercharged': isSupercharged,
      'isSharingData': isSharingData,
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
      bio: map['bio'] as String,
      imageUrl: map['imageUrl'] as String?,
      bannerImageUrl: map['bannerImageUrl'] as String?,
      followers: map['followers'] == null
          ? []
          : List<String>.from(map['followers'] as List<dynamic>),
      following: map['following'] == null
          ? []
          : List<String>.from(map['following'] as List<dynamic>),
      isBusinessAcc: map['isBusinessAcc'] as bool,
      isServiceProvider: map['isServiceProvider'] as bool,
      isRanked: map['isRanked'] as bool,
      deviceToken: map['deviceToken'] as String,
      isSupercharged: map['isSupercharged'] as bool,
      isSharingData: map['isSharingData'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthData.fromJson(String source) =>
      AuthData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AuthData(email: $email, domain: $domain, fullname: $fullname, uid: $uid, id: $id, createdAt: $createdAt, bio: $bio, imageUrl: $imageUrl, bannerImageUrl: $bannerImageUrl, followers: $followers, following: $following, isBusinessAcc: $isBusinessAcc, isServiceProvider: $isServiceProvider, isRanked: $isRanked, deviceToken: $deviceToken, isSupercharged: $isSupercharged, isSharingData: $isSharingData)';
  }

  @override
  bool operator ==(covariant AuthData other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.domain == domain &&
        other.fullname == fullname &&
        other.uid == uid &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.bio == bio &&
        other.imageUrl == imageUrl &&
        other.bannerImageUrl == bannerImageUrl &&
        listEquals(other.followers, followers) &&
        listEquals(other.following, following) &&
        other.isBusinessAcc == isBusinessAcc &&
        other.isServiceProvider == isServiceProvider &&
        other.isRanked == isRanked &&
        other.deviceToken == deviceToken &&
        other.isSupercharged == isSupercharged &&
        other.isSharingData == isSharingData;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        domain.hashCode ^
        fullname.hashCode ^
        uid.hashCode ^
        id.hashCode ^
        createdAt.hashCode ^
        bio.hashCode ^
        imageUrl.hashCode ^
        bannerImageUrl.hashCode ^
        followers.hashCode ^
        following.hashCode ^
        isBusinessAcc.hashCode ^
        isServiceProvider.hashCode ^
        isRanked.hashCode ^
        deviceToken.hashCode ^
        isSupercharged.hashCode ^
        isSharingData.hashCode;
  }
}
