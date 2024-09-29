part of '../bloc.dart';

class SendNotificationState extends Equatable {
  static bool match(NotificationsState a, NotificationsState b) => a.send != b.send;

  final String? message;

  const SendNotificationState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}


class SendNotificationDefault extends SendNotificationState {
  const SendNotificationDefault();
}

class SendNotificationLoading extends SendNotificationState {
  const SendNotificationLoading();
}

class SendNotificationSuccess extends SendNotificationState {
  const SendNotificationSuccess();
}

class SendNotificationFailure extends SendNotificationState {
  const SendNotificationFailure({
    required String message,
  }) : super(message: message);
}
