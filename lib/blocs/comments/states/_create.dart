part of '../bloc.dart';

class CreateCommentState extends Equatable {
  static bool match(CommentsState a, CommentsState b) => a.create != b.create;

  final String? message;

  const CreateCommentState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class CreateCommentDefault extends CreateCommentState {
  const CreateCommentDefault();
}

class CreateCommentLoading extends CreateCommentState {
  const CreateCommentLoading();
}

class CreateCommentSuccess extends CreateCommentState {
  const CreateCommentSuccess();
}

class CreateCommentFailure extends CreateCommentState {
  const CreateCommentFailure({
    required String message,
  }) : super(message: message);
}
