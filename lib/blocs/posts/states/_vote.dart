part of '../bloc.dart';

@immutable
class VotePostState extends Equatable {
  static bool match(PostsState a, PostsState b) => a.vote != b.vote;

  final String? message;

  const VotePostState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

@immutable
class VotePostDefault extends VotePostState {
  const VotePostDefault();
}

@immutable
class VotePostLoading extends VotePostState {
  const VotePostLoading();
}

@immutable
class VotePostSuccess extends VotePostState {
  const VotePostSuccess();
}

@immutable
class VotePostFailure extends VotePostState {
  const VotePostFailure({
    required String message,
  }) : super(message: message);
}
