part of '../bloc.dart';

class NotificationCounterState extends Equatable {
  static bool match(NotificationsState a, NotificationsState b) => a.counter != b.counter;

  final String? message;

  const NotificationCounterState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}


class NotificationCounterDefault extends NotificationCounterState {
  const NotificationCounterDefault();
}

class NotificationCounterLoading extends NotificationCounterState {
  const NotificationCounterLoading();
}

class NotificationCounterSuccess extends NotificationCounterState {
  const NotificationCounterSuccess();
}

class NotificationCounterFailure extends NotificationCounterState {
  const NotificationCounterFailure({
    required String message,
  }) : super(message: message);
}
