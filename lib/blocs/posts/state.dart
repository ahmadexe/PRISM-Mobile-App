part of 'bloc.dart';

@immutable
class PostsState extends Equatable {
  final List<PostData>? data;
  final PostsfetchState? fetch;
  final CreatePostState? post;
  final VotePostState? vote;

  const PostsState({
    this.data,
    this.fetch,
    this.post,
    this.vote,
  });

  PostsState copyWith({
    List<PostData>? data,
    PostsfetchState? fetch,
    CreatePostState? post,
    VotePostState? vote,
  }) {
    return PostsState(
      data: data ?? this.data,
      fetch: fetch ?? this.fetch,
      post: post ?? this.post,
      vote: vote ?? this.vote,
    );
  }

  @override
  List<Object?> get props => [
        data,
        fetch,
        post,
        vote,
      ];
}

@immutable
final class PostsDefault extends PostsState {
  const PostsDefault()
      : super(
          data: null,
          fetch: const PostsfetchDefault(),
          post: const CreatePostDefault(),
          vote: const VotePostDefault(),
        );
}
