import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prism/services/api.dart';

part 'event.dart';
part 'state.dart';
part 'data_provider.dart';

class NodeBloc extends Bloc<NodeEvent, NodeState> {
  NodeBloc() : super(const NodeInitial()) {
    on<GetConnectionString>(_getConnectionString);
  }

  Future<void> _getConnectionString(
      GetConnectionString event, Emitter<NodeState> emit) async {
    emit(const NodeLoading());
    try {
      final data = await _NodeProvider.getConnectionString();
      emit(NodeLoaded(data: data));
    } catch (e) {
      emit(NodeError(error: e.toString()));
    }
  }
}
