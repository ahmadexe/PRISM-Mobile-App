part of '../bloc.dart';

class NodeState extends Equatable {
  static bool match(ChainState a, ChainState b) => a.node != b.node;
  final String? message;

  const NodeState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class NodeDefault extends NodeState {
  const NodeDefault();
}

class NodeLoading extends NodeState {
  const NodeLoading();
}

class NodeSuccess extends NodeState {
  const NodeSuccess();
}

class NodeFailure extends NodeState {
  const NodeFailure({
    required String message,
  }) : super(message: message);
}
