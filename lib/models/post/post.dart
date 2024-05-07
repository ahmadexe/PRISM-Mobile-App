import 'dart:convert';

class Post {
  final String id;
  final String userId;
  final String? imageUrl;
  final String? caption;
  final String userName;
  final String category;
  final String userProfilePic;
  int noOfViews;
  int upVotes;
  int downVotes;
  int noOfComments;
  final bool isBanned;
  final int createdAt;
  
  Post({
    required this.id,
    required this.userId,
    this.imageUrl,
    this.caption,
    required this.userName,
    required this.category,
    required this.userProfilePic,
    required this.noOfViews,
    required this.upVotes,
    required this.downVotes,
    required this.noOfComments,
    required this.isBanned,
    required this.createdAt,
  });

  Post copyWith({
    String? id,
    String? userId,
    String? imageUrl,
    String? caption,
    String? userName,
    String? category,
    String? userProfilePic,
    int? noOfViews,
    int? upVotes,
    int? downVotes,
    int? noOfComments,
    bool? isBanned,
    int? createdAt,
  }) {
    return Post(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      imageUrl: imageUrl ?? this.imageUrl,
      caption: caption ?? this.caption,
      userName: userName ?? this.userName,
      category: category ?? this.category,
      userProfilePic: userProfilePic ?? this.userProfilePic,
      noOfViews: noOfViews ?? this.noOfViews,
      upVotes: upVotes ?? this.upVotes,
      downVotes: downVotes ?? this.downVotes,
      noOfComments: noOfComments ?? this.noOfComments,
      isBanned: isBanned ?? this.isBanned,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'imageUrl': imageUrl,
      'caption': caption,
      'userName': userName,
      'category': category,
      'userProfilePic': userProfilePic,
      'noOfViews': noOfViews,
      'upVotes': upVotes,
      'downVotes': downVotes,
      'noOfComments': noOfComments,
      'isBanned': isBanned,
      'createdAt': createdAt,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] as String,
      userId: map['userId'] as String,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      caption: map['caption'] != null ? map['caption'] as String : null,
      userName: map['userName'] as String,
      category: map['category'] as String,
      userProfilePic: map['userProfilePic'] as String,
      noOfViews: map['noOfViews'] as int,
      upVotes: map['upVotes'] as int,
      downVotes: map['downVotes'] as int,
      noOfComments: map['noOfComments'] as int,
      isBanned: map['isBanned'] as bool,
      createdAt: map['createdAt'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Post(id: $id, userId: $userId, imageUrl: $imageUrl, caption: $caption, userName: $userName, category: $category, userProfilePic: $userProfilePic, noOfViews: $noOfViews, upVotes: $upVotes, downVotes: $downVotes, noOfComments: $noOfComments, isBanned: $isBanned, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.userId == userId &&
      other.imageUrl == imageUrl &&
      other.caption == caption &&
      other.userName == userName &&
      other.category == category &&
      other.userProfilePic == userProfilePic &&
      other.noOfViews == noOfViews &&
      other.upVotes == upVotes &&
      other.downVotes == downVotes &&
      other.noOfComments == noOfComments &&
      other.isBanned == isBanned &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      userId.hashCode ^
      imageUrl.hashCode ^
      caption.hashCode ^
      userName.hashCode ^
      category.hashCode ^
      userProfilePic.hashCode ^
      noOfViews.hashCode ^
      upVotes.hashCode ^
      downVotes.hashCode ^
      noOfComments.hashCode ^
      isBanned.hashCode ^
      createdAt.hashCode;
  }
}
