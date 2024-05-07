part of '../bloc.dart';

class PostsfetchState extends Equatable {
  static bool match(PostsState a, PostsState b) => a.fetch != b.fetch;

  final String? message;

  const PostsfetchState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class PostsfetchDefault extends PostsfetchState {
  const PostsfetchDefault();
}

class PostsfetchLoading extends PostsfetchState {
  const PostsfetchLoading();
}

class PostsfetchSuccess extends PostsfetchState {
  const PostsfetchSuccess();
}

class PostsfetchFailure extends PostsfetchState {
  const PostsfetchFailure({
    required String message,
  }) : super(message: message);
}
