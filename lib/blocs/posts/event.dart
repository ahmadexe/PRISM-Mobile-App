part of 'bloc.dart';

sealed class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class PostsFetchEvent extends PostsEvent {
  const PostsFetchEvent();
}

class PostCreateEvent extends PostsEvent {
  final Map<String, dynamic> payload;
  final XFile? image;

  const PostCreateEvent({required this.payload, this.image});

  @override
  List<Object> get props => [payload];
}

class PostVoteEvent extends PostsEvent {
  final String postId;
  final String userId;
  final bool isUpVote;
  final int index;

  const PostVoteEvent({
    required this.postId,
    required this.userId,
    required this.isUpVote,
    required this.index,
  });

  @override
  List<Object> get props => [postId, isUpVote];
}

class ClearPostBlocEvent extends PostsEvent {
  const ClearPostBlocEvent();
}

class ReportPostEvent extends PostsEvent {
  final String postId;
  final String url;
  final String type;

  const ReportPostEvent({
    required this.postId,
    required this.url,
    required this.type,
  });

  @override
  List<Object> get props => [postId, type, url];
}