import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prism/services/api.dart';

part 'event.dart';
part 'state.dart';
part 'adaptor.dart';
part 'data_provider.dart';

part 'states/_create_job.dart';

class JobsBloc extends Bloc<JobsEvent, JobsState> {
  JobsBloc() : super(const JobsInitial()) {
    on<CreateJob>(_createJob);
  }

  final _adaptor = _Adaptor();

  Future<void> _createJob(CreateJob event, Emitter<JobsState> emit) async {
    emit(const JobsState(
      create: CreateJobLoading(),
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
        const JobsState(
          create: CreateJobSuccess(),
        ),
      );
    } catch (e) {
      emit(
        JobsState(
          create: CreateJobFailure(
            error: e.toString(),
          ),
        ),
      );
    }
  }
}
