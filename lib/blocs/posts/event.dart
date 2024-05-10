part of 'bloc.dart';

sealed class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class PostsFetchEvent extends PostsEvent {
  const PostsFetchEvent();
}

class PostCreateEvent extends PostsEvent {
  final Map<String, dynamic> payload;
  final XFile? image;

  const PostCreateEvent(this.payload, this.image);

  @override
  List<Object> get props => [payload];
}