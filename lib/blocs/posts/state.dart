part of 'bloc.dart';

class PostsState extends Equatable {
  final List<Post>? data;
  final PostsfetchState? fetch;

  const PostsState({
    this.data,
    this.fetch,
  });

  PostsState copyWith({
    List<Post>? data,
    PostsfetchState? fetch,
  }) {
    return PostsState(
      data: data ?? this.data,
      fetch: fetch ?? this.fetch,
    );
  }

  @override
  List<Object?> get props => [data];
}

final class PostsDefault extends PostsState {
  const PostsDefault()
      : super(
          fetch: const PostsfetchDefault(),
          data: null,
        );
}
