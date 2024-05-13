part of '../bloc.dart';

class FetchCommentsState extends Equatable {
  static bool match(CommentsState a, CommentsState b) => a.fetch != b.fetch;
  final String? message;

  const FetchCommentsState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class FetchCommentsDefault extends FetchCommentsState {
  const FetchCommentsDefault();
}

class FetchCommentsLoading extends FetchCommentsState {
  const FetchCommentsLoading();
}

class FetchCommentsSuccess extends FetchCommentsState {
  const FetchCommentsSuccess();
}

class FetchCommentsFailure extends FetchCommentsState {
  const FetchCommentsFailure({
    required String message,
  }) : super(message: message);
}
