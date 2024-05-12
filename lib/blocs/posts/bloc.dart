import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prism/models/post/post.dart';
import 'package:prism/services/api.dart';

part 'event.dart';
part 'state.dart';

part 'data_provider.dart';
part 'adaptor.dart';

part 'states/_fetch.dart';
part 'states/_post.dart';
part 'states/_vote.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(const PostsDefault()) {
    on<PostsFetchEvent>(_fetchPosts);
    on<PostCreateEvent>(_createPost);
    on<PostVoteEvent>(_votePost);
  }

  final _adaptor = _PostAdaptor();

  Future<void> _fetchPosts(
      PostsFetchEvent event, Emitter<PostsState> emit) async {
    emit(state.copyWith(fetch: const PostsfetchLoading()));

    try {
      final posts = await _PostProvider.getPosts();
      emit(
        state.copyWith(
          fetch: const PostsfetchSuccess(),
          data: posts,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          fetch: PostsfetchFailure(
            message: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _createPost(
      PostCreateEvent event, Emitter<PostsState> emit) async {
    emit(state.copyWith(post: const CreatePostLoading()));
    try {
      final payload = event.payload;
      final image = event.image;

      await _adaptor.createPost(payload, image);

      emit(
        state.copyWith(
          post: const CreatePostSuccess(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          post: CreatePostFailure(
            message: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _votePost(PostVoteEvent event, Emitter<PostsState> emit) async {
    emit(state.copyWith(vote: const VotePostLoading()));

    try {
      final userId = event.userId;
      final postId = event.postId;
      final isUpVote = event.isUpVote;

      final updatedPost = await _PostProvider.vote(postId, userId, isUpVote);

      List<PostData> posts = state.data!;
      final index = event.index;

      posts[index] = updatedPost;

      emit(
        state.copyWith(
          vote: const VotePostSuccess(),
          data: posts,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          vote: VotePostFailure(
            message: e.toString(),
          ),
        ),
      );
    }
  }
}
