import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';
part 'adaptor.dart';
part 'data_provider.dart';

part 'states/_create_job.dart';

class JobsBloc extends Bloc<JobsEvent, JobsState> {
  JobsBloc() : super(JobsInitial()) {
    on<JobsEvent>((event, emit) {});
  }
}
