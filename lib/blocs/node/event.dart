part of 'bloc.dart';

sealed class NodeEvent extends Equatable {
  const NodeEvent();

  @override
  List<Object> get props => [];
}

final class GetConnectionString extends NodeEvent {}