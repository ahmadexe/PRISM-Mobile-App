part of 'bloc.dart';

sealed class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

class SendNotification extends NotificationsEvent {
  final String title;
  final String body;
  final String topic;

  const SendNotification({
    required this.title,
    required this.body,
    required this.topic,
  });

  @override
  List<Object> get props => [title, body, topic,];
}