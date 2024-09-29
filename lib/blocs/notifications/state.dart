// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bloc.dart';

class NotificationsState extends Equatable {
  final SendNotificationState send;

  const NotificationsState({
    required this.send,
  });
  
  @override
  List<Object> get props => [
    send,
  ];

  NotificationsState copyWith({
    SendNotificationState? send,
  }) {
    return NotificationsState(
      send: send ?? this.send,
    );
  }
}

final class NotificationsInitial extends NotificationsState {
  const NotificationsInitial() : super(
    send: const SendNotificationDefault(),
  );
}
