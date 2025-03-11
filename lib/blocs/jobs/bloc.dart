import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prism/models/job/job.dart';
import 'package:prism/models/job/job_application.dart';
import 'package:prism/services/api.dart';

part 'event.dart';
part 'state.dart';
part 'repository.dart';
part 'data_provider.dart';

part 'states/_create_job.dart';
part 'states/_fetch_jobs.dart';
part 'states/_like.dart';
part 'states/_apply.dart';
part 'states/_fetch_myjobs.dart';
part 'states/_fetch_applications.dart';
part 'states/_hire.dart';

class JobsBloc extends Bloc<JobsEvent, JobsState> {
  JobsBloc() : super(const JobsInitial()) {
    on<CreateJob>(_createJob);
    on<FetchJobs>(_fetchJobs);
    on<LikeUnlikeJob>(_likeUnlikeJob);
    on<ApplyForJob>(_applyForJob);
    on<FetchMyJobs>(_fetchMyJobs);
    on<FetchApplications>(_fetchApplications);
    on<HireApplicant>(_hrieApplicant);
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

  Future<void> _likeUnlikeJob(
      LikeUnlikeJob event, Emitter<JobsState> emit) async {
    emit(state.copyWith(
      like: const LikeToggleLoading(),
    ));

    try {
      await _adaptor.likeUnlikeJob(event.jobId, event.userId);

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

  Future<void> _applyForJob(ApplyForJob event, Emitter<JobsState> emit) async {
    emit(
      state.copyWith(
        apply: const ApplyForJobLoading(),
      ),
    );
    try {
      await _adaptor.applyForJob(
        event.jobId,
        event.userId,
        event.username,
        event.avatar,
      );

      emit(
        state.copyWith(
          apply: const ApplyForJobSuccess(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          apply: ApplyForJobFailure(error: e.toString()),
        ),
      );
    }
  }

  Future<void> _fetchMyJobs(FetchMyJobs event, Emitter<JobsState> emit) async {
    emit(
      state.copyWith(
        myJobs: const FetchMyJobsLoading(),
      ),
    );

    try {
      final jobs = await _jobsProvider.fetchMyJobs(event.userId);
      emit(
        state.copyWith(
          myJobs: FetchMyJobsSuccess(
            jobs: jobs,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          myJobs: FetchMyJobsFailure(error: e.toString()),
        ),
      );
    }
  }

  Future<void> _fetchApplications(
      FetchApplications event, Emitter<JobsState> emit) async {
    emit(
      state.copyWith(
        applications: const FetchApplicationsLoading(),
      ),
    );

    try {
      final applications = await _jobsProvider.fetchApplications(
        event.id,
        event.isUser,
      );
      emit(
        state.copyWith(
          applications: FetchApplicationsSuccess(
            applications: applications,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          applications: FetchApplicationsFailure(error: e.toString()),
        ),
      );
    }
  }

  Future<void> _hrieApplicant(
      HireApplicant event, Emitter<JobsState> emit) async {
    emit(
      state.copyWith(
        hire: const HireApplicantLoading(),
      ),
    );

    try {
      await _adaptor.hireApplicant(event.userId, event.jobId);
      emit(
        state.copyWith(
          hire: const HireApplicantSuccess(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          hire: HireApplicantFailure(error: e.toString()),
        ),
      );
    }
  }
}
