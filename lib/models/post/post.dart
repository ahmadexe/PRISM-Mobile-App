import 'dart:convert';

import 'package:flutter/foundation.dart';

class Post {
  final String id;
  final String userId;
  final String? imageUrl;
  final String? description;
  final String userName;
  final String category;
  final String? userProfilePic;
  int noOfViews;
  int upVotes;
  int downVotes;
  int noOfComments;
  final DateTime createdAt;
  List<String> upVotedBy;
  List<String> downVotedBy;
  List<String> commentedBy;
  final String title;
  
  Post({
    required this.id,
    required this.userId,
    this.imageUrl,
    this.description,
    required this.userName,
    required this.category,
    this.userProfilePic,
    required this.noOfViews,
    required this.upVotes,
    required this.downVotes,
    required this.noOfComments,
    required this.createdAt,
    required this.upVotedBy,
    required this.downVotedBy,
    required this.commentedBy,
    required this.title,
  });


  Post copyWith({
    String? id,
    String? userId,
    String? imageUrl,
    String? description,
    String? userName,
    String? category,
    String? userProfilePic,
    int? noOfViews,
    int? upVotes,
    int? downVotes,
    int? noOfComments,
    DateTime? createdAt,
    List<String>? upVotedBy,
    List<String>? downVotedBy,
    List<String>? commentedBy,
    String? title,
  }) {
    return Post(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      userName: userName ?? this.userName,
      category: category ?? this.category,
      userProfilePic: userProfilePic ?? this.userProfilePic,
      noOfViews: noOfViews ?? this.noOfViews,
      upVotes: upVotes ?? this.upVotes,
      downVotes: downVotes ?? this.downVotes,
      noOfComments: noOfComments ?? this.noOfComments,
      createdAt: createdAt ?? this.createdAt,
      upVotedBy: upVotedBy ?? this.upVotedBy,
      downVotedBy: downVotedBy ?? this.downVotedBy,
      commentedBy: commentedBy ?? this.commentedBy,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'imageUrl': imageUrl,
      'description': description,
      'userName': userName,
      'category': category,
      'userProfilePic': userProfilePic,
      'noOfViews': noOfViews,
      'upVotes': upVotes,
      'downVotes': downVotes,
      'noOfComments': noOfComments,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'upVotedBy': upVotedBy,
      'downVotedBy': downVotedBy,
      'commentedBy': commentedBy,
      'title': title,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] as String,
      userId: map['userId'] as String,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      userName: map['userName'] as String,
      category: map['category'] as String,
      userProfilePic: map['userProfilePic'] != null ? map['userProfilePic'] as String : null,
      noOfViews: map['noOfViews'] as int,
      upVotes: map['upVotes'] as int,
      downVotes: map['downVotes'] as int,
      noOfComments: map['noOfComments'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      upVotedBy: List<String>.from((map['upVotedBy'])),
      downVotedBy: List<String>.from((map['downVotedBy'])),
      commentedBy: List<String>.from((map['commentedBy'])),
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Post(id: $id, userId: $userId, imageUrl: $imageUrl, description: $description, userName: $userName, category: $category, userProfilePic: $userProfilePic, noOfViews: $noOfViews, upVotes: $upVotes, downVotes: $downVotes, noOfComments: $noOfComments, createdAt: $createdAt, upVotedBy: $upVotedBy, downVotedBy: $downVotedBy, commentedBy: $commentedBy, title: $title)';
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.userId == userId &&
      other.imageUrl == imageUrl &&
      other.description == description &&
      other.userName == userName &&
      other.category == category &&
      other.userProfilePic == userProfilePic &&
      other.noOfViews == noOfViews &&
      other.upVotes == upVotes &&
      other.downVotes == downVotes &&
      other.noOfComments == noOfComments &&
      other.createdAt == createdAt &&
      listEquals(other.upVotedBy, upVotedBy) &&
      listEquals(other.downVotedBy, downVotedBy) &&
      listEquals(other.commentedBy, commentedBy) &&
      other.title == title;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      userId.hashCode ^
      imageUrl.hashCode ^
      description.hashCode ^
      userName.hashCode ^
      category.hashCode ^
      userProfilePic.hashCode ^
      noOfViews.hashCode ^
      upVotes.hashCode ^
      downVotes.hashCode ^
      noOfComments.hashCode ^
      createdAt.hashCode ^
      upVotedBy.hashCode ^
      downVotedBy.hashCode ^
      commentedBy.hashCode ^
      title.hashCode;
  }
}
