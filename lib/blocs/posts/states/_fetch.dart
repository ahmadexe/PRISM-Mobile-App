part of '../bloc.dart';

@immutable
class PostsfetchState extends Equatable {
  static bool match(PostsState a, PostsState b) => a.fetch != b.fetch;

  final String? message;

  const PostsfetchState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}


@immutable
class PostsfetchDefault extends PostsfetchState {
  const PostsfetchDefault();
}

@immutable
class PostsfetchLoading extends PostsfetchState {
  const PostsfetchLoading();
}

@immutable
class PostsfetchSuccess extends PostsfetchState {
  const PostsfetchSuccess();
}

@immutable
class PostsfetchFailure extends PostsfetchState {
  const PostsfetchFailure({
    required String message,
  }) : super(message: message);
}
