part of '../bloc.dart';

@immutable
class ReportPostState extends Equatable {
  static bool match(PostsState a, PostsState b) => a.report != b.report;

  final String? message;

  const ReportPostState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

@immutable
class ReportPostDefault extends ReportPostState {
  const ReportPostDefault();
}

@immutable
class ReportPostLoading extends ReportPostState {
  const ReportPostLoading();
}

@immutable
class ReportPostSuccess extends ReportPostState {
  const ReportPostSuccess();
}

@immutable
class ReportPostFailure extends ReportPostState {
  const ReportPostFailure({
    required String message,
  }) : super(message: message);
}
