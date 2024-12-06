import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prism/services/api.dart';

part 'event.dart';
part 'state.dart';
part 'data_provider.dart';
part 'repository.dart';

part 'states/_node.dart';
part 'states/_data.dart';

class BlockchainBloc extends Bloc<ChainEvent, ChainState> {
  BlockchainBloc() : super(const ChainInitial()) {
    on<GetConnectionString>(_getConnectionString);
    on<PostData>(_postData);
  }
  final repo = _ChainRepo();

  Future<void> _postData(PostData event, Emitter<ChainState> emit) async {
    emit(
      state.copyWith(
        data: const PostDataLoading(),
      ),
    );
    try {
      await repo.postData(event.data, event.blockchainAddress, state.address!);
      emit(
        state.copyWith(
          data: const PostDataSuccess(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          data: PostDataFailure(message: e.toString()),
        ),
      );
    }
  }

  Future<void> _getConnectionString(
      GetConnectionString event, Emitter<ChainState> emit) async {
    emit(
      state.copyWith(
        node: const NodeLoading(),
      ),
    );
    try {
      final data = await _ChainProvider.getConnectionString();
      emit(
        state.copyWith(
          node: const NodeSuccess(),
          address: data,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          node: NodeFailure(message: e.toString()),
        ),
      );
    }
  }
}
