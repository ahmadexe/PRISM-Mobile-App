import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prism/models/job/job.dart';
import 'package:prism/services/api.dart';

part 'event.dart';
part 'state.dart';
part 'adaptor.dart';
part 'data_provider.dart';

part 'states/_create_job.dart';
part 'states/_fetch_jobs.dart';
part 'states/_like.dart';

class JobsBloc extends Bloc<JobsEvent, JobsState> {
  JobsBloc() : super(const JobsInitial()) {
    on<CreateJob>(_createJob);
    on<FetchJobs>(_fetchJobs);
    on<LikeUnlikeJob>(_likeUnlikeJob);
  }

  final _adaptor = _Adaptor();
  final _jobsProvider = _JobsDataProvider();

  Future<void> _createJob(CreateJob event, Emitter<JobsState> emit) async {
    emit(state.copyWith(
      create: const CreateJobLoading(),
    ));

    try {
      await _adaptor.createJob(
        event.title,
        event.description,
        event.budget,
        event.budgetMeta,
        event.country,
        event.postedBy,
        event.username,
        event.avatar,
        event.keywords,
      );
      emit(
        state.copyWith(
          create: const CreateJobSuccess(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          create: CreateJobFailure(error: e.toString()),
        ),
      );
    }
  }

  Future<void> _fetchJobs(FetchJobs event, Emitter<JobsState> emit) async {
    emit(state.copyWith(
      fetch: const FetchJobsLoading(),
    ));

    try {
      final jobs = await _jobsProvider.fetchJobs();
      emit(
        state.copyWith(
          fetch: const FetchJobsSuccess(),
          jobs: jobs,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          fetch: FetchJobsFailure(error: e.toString()),
        ),
      );
    }
  }

  Future<void> _likeUnlikeJob(LikeUnlikeJob event, Emitter<JobsState> emit) async {
    emit(state.copyWith(
      like: const LikeToggleLoading(),
    ));

    try {
      await _adaptor.likeUnlikeJob(event.jobId, event.userId);
      final jobs = state.jobs ?? [];
      final job = jobs.firstWhere((e) => e.id == event.jobId);
      final likedBy = job.likedBy;
      if (likedBy.contains(event.userId)) {
        likedBy.remove(event.userId);
      } else {
        likedBy.add(event.userId);
      }

      emit(
        state.copyWith(
          like: const LikeToggleSuccess(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          like: LikeToggleFailure(error: e.toString()),
        ),
      );
    }
  }  
}
