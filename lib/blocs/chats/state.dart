part of 'bloc.dart';

sealed class ChatsState extends Equatable {
  const ChatsState();
  
  @override
  List<Object> get props => [];
}

final class ChatsInitial extends ChatsState {}
