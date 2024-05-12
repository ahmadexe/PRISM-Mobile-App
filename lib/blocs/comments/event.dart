part of 'bloc.dart';

sealed class CommentsEvent extends Equatable {
  const CommentsEvent();

  @override
  List<Object> get props => [];
}

class CreateCommentEvent extends CommentsEvent {
  final String userId;
  final String postId;
  final String content;
  final String userName;
  final String? userProfilePic;
  final DateTime createdAt;

  const CreateCommentEvent({
    required this.userId,
    required this.postId,
    required this.content,
    required this.userName,
    this.userProfilePic,
    required this.createdAt,
  });
}

class FetchCommentsEvent extends CommentsEvent {
  final String postId;

  const FetchCommentsEvent({
    required this.postId,
  });
}
