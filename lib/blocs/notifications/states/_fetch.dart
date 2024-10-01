part of '../bloc.dart';

class FetchNotificationState extends Equatable {
  static bool match(NotificationsState a, NotificationsState b) =>
      a.fetch != b.fetch;

  final String? message;

  const FetchNotificationState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class FetchNotificationDefault extends FetchNotificationState {
  const FetchNotificationDefault();
}

class FetchNotificationLoading extends FetchNotificationState {
  const FetchNotificationLoading();
}

class FetchNotificationSuccess extends FetchNotificationState {
  const FetchNotificationSuccess();
}

class FetchNotificationFailure extends FetchNotificationState {
  const FetchNotificationFailure({
    required String message,
  }) : super(message: message);
}
