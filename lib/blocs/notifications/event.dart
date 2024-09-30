part of 'bloc.dart';

sealed class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

class SendNotification extends NotificationsEvent {
  final String title;
  final String body;
  final String uid;
  final String deviceToken;
  final String type;

  const SendNotification({
    required this.title,
    required this.body,
    required this.uid,
    required this.deviceToken,
    required this.type,
  });

  @override
  List<Object> get props => [
        title,
        body,
        uid,
        deviceToken,
        type,
      ];
}

class FetchNotifications extends NotificationsEvent {
  final String uid;
  const FetchNotifications({
    required this.uid,
  });
}
