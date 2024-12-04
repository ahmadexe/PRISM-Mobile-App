part of 'bloc.dart';

class NodeState extends Equatable {
  final String? address;
  final String? message;

  const NodeState({
    this.address,
    this.message
  });

  @override
  List<Object?> get props => [address, message];
}

class NodeInitial extends NodeState {
  const NodeInitial() : super();
}

class NodeLoading extends NodeState {
  const NodeLoading() : super();
}

class NodeLoaded extends NodeState {
  final String data;

  const NodeLoaded({
    required this.data,
  }) : super(address: data);
}

class NodeError extends NodeState {
  final String error;

  const NodeError({
    required this.error,
  }) : super(message: error);
}
