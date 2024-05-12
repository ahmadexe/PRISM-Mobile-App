part of 'bloc.dart';

class CommentsState extends Equatable {
  final List<Comment>? data;
  final CreateCommentState create;
  final FetchCommentsState fetch;

  const CommentsState({
    this.data,
    required this.create,
    required this.fetch,
  });

  CommentsState copyWith({
    List<Comment>? data,
    CreateCommentState? create,
    FetchCommentsState? fetch,
  }) {
    return CommentsState(
      data: data ?? this.data,
      create: create ?? this.create,
      fetch: fetch ?? this.fetch,
    );
  }

  @override
  List<Object?> get props => [
        data,
        create,
        fetch,
      ];
}

class CommentsDefault extends CommentsState {
  const CommentsDefault()
      : super(
          data: null,
          create: const CreateCommentDefault(),
          fetch: const FetchCommentsDefault(),
        );
}
