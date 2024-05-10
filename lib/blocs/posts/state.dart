part of 'bloc.dart';

@immutable
class PostsState extends Equatable {
  final List<Post>? data;
  final PostsfetchState? fetch;
  final CreatePostState? post;

  const PostsState({
    this.data,
    this.fetch,
    this.post,
  });

  PostsState copyWith({
    List<Post>? data,
    PostsfetchState? fetch,
    CreatePostState? post,
  }) {
    return PostsState(
      data: data ?? this.data,
      fetch: fetch ?? this.fetch,
      post: post ?? this.post,
    );
  }

  @override
  List<Object?> get props => [
        data,
        fetch,
        post,
      ];
}

@immutable
final class PostsDefault extends PostsState {
  const PostsDefault()
      : super(
          data: null,
          fetch: const PostsfetchDefault(),
          post: const CreatePostDefault(),
        );
}
