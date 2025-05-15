part of 'bloc.dart';

class NotificationsState extends Equatable {
  final List<NotificationModel>? data;
  final SendNotificationState send;
  final FetchNotificationState fetch;
  final NotificationCounterState counter;

  const NotificationsState({
    required this.send,
    required this.fetch,
    required this.counter,
    this.data,
  });

  @override
  List<Object?> get props => [
        data,
        send,
        fetch,
        counter,
      ];

  NotificationsState copyWith({
    List<NotificationModel>? data,
    SendNotificationState? send,
    FetchNotificationState? fetch,
    NotificationCounterState? counter,
  }) {
    return NotificationsState(
      data: data ?? this.data,
      send: send ?? this.send,
      fetch: fetch ?? this.fetch,
      counter: counter ?? this.counter,
    );
  }
}

final class NotificationsInitial extends NotificationsState {
  const NotificationsInitial()
      : super(
          send: const SendNotificationDefault(),
          fetch: const FetchNotificationDefault(),
          counter: const NotificationCounterDefault(),
        );
}
