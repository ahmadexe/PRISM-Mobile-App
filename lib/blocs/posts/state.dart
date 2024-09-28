part of 'bloc.dart';

@immutable
class PostsState extends Equatable {
  final List<PostData>? data;
  final PostsfetchState? fetch;
  final CreatePostState? post;
  final VotePostState? vote;
  final ReportPostState? report;

  const PostsState({
    this.data,
    this.fetch,
    this.post,
    this.vote,
    this.report,
  });

  PostsState copyWith({
    List<PostData>? data,
    PostsfetchState? fetch,
    CreatePostState? post,
    VotePostState? vote,
    ReportPostState? report,
  }) {
    return PostsState(
      data: data ?? this.data,
      fetch: fetch ?? this.fetch,
      post: post ?? this.post,
      vote: vote ?? this.vote,
      report: report ?? this.report,
    );
  }

  @override
  List<Object?> get props => [
        data,
        fetch,
        post,
        vote,
        report,
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
          report: const ReportPostDefault(),
        );
}
