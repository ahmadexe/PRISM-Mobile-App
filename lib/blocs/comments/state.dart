part of 'bloc.dart';

sealed class CommentsState extends Equatable {
  const CommentsState();
  
  @override
  List<Object> get props => [];
}

final class CommentsInitial extends CommentsState {}
