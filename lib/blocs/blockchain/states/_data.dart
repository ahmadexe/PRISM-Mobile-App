part of '../bloc.dart';

class PostDataState extends Equatable {
  static bool match(ChainState a, ChainState b) => a.data != b.data;
  final String? message;

  const PostDataState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class PostDataDefault extends PostDataState {
  const PostDataDefault();
}

class PostDataLoading extends PostDataState {
  const PostDataLoading();
}

class PostDataSuccess extends PostDataState {
  const PostDataSuccess();
}

class PostDataFailure extends PostDataState {
  const PostDataFailure({
    required String message,
  }) : super(message: message);
}
