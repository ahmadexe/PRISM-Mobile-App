part of '../bloc.dart';

@immutable
class CreatePostState extends Equatable {
  static bool match(PostsState a, PostsState b) => a.post != b.post;

  final String? message;

  const CreatePostState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

@immutable
class CreatePostDefault extends CreatePostState {
  const CreatePostDefault();
}

@immutable
class CreatePostLoading extends CreatePostState {
  const CreatePostLoading();
}

@immutable
class CreatePostSuccess extends CreatePostState {
  const CreatePostSuccess();
}

@immutable
class CreatePostFailure extends CreatePostState {
  const CreatePostFailure({
    required String message,
  }) : super(message: message);
}
