import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prism/models/post/comment.dart';
import 'package:prism/services/api.dart';

part 'event.dart';
part 'state.dart';
part 'adaptor.dart';
part 'data_provider.dart';

part 'states/_create.dart';
part 'states/_fetch.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentsBloc() : super(const CommentsDefault()) {
    on<CreateCommentEvent>(_createComment);
    on<FetchCommentsEvent>(_fetchComments);
  }

  final _adaptor = _CommentAdaptor();

  Future<void> _createComment(
      CreateCommentEvent event, Emitter<CommentsState> emit) async {
    emit(state.copyWith(create: const CreateCommentLoading()));
    try {
      final comment = await _adaptor.createComment(
        event.userId,
        event.postId,
        event.content,
        event.userName,
        event.userProfilePic,
        event.createdAt,
      );

      emit(
        state.copyWith(
          create: const CreateCommentSuccess(),
          data: [comment, ...state.data ?? []],
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          create: CreateCommentFailure(
            message: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _fetchComments(
      FetchCommentsEvent event, Emitter<CommentsState> emit) async {
    emit(state.copyWith(fetch: const FetchCommentsLoading()));

    try {
      final comments = await _CommentProvider.getComments(event.postId);
      emit(
        state.copyWith(
          fetch: const FetchCommentsSuccess(),
          data: comments,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          fetch: FetchCommentsFailure(
            message: e.toString(),
          ),
        ),
      );
    }
  }
}
