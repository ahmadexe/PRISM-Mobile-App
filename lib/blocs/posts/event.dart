part of 'bloc.dart';

sealed class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class PostsFetchEvent extends PostsEvent {
  const PostsFetchEvent();
}