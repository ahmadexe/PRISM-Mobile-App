import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prism/models/notification/notification_model.dart';
import 'package:prism/services/notifications/base.dart';

part 'event.dart';
part 'state.dart';
part 'adaptor.dart';
part 'data_provider.dart';

part 'states/_send.dart';
part 'states/_fetch.dart';
part 'states/_counter.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(const NotificationsInitial()) {
    on<SendNotification>(_sendNotification);
  }

  Future<void> _sendNotification(
      SendNotification event, Emitter<NotificationsState> emit) async {
    emit(
      state.copyWith(
        send: const SendNotificationLoading(),
      ),
    );
    try {
      await NotificationProvider.sendNotification(
        event.title,
        event.body,
        event.uid,
        event.deviceToken,
        event.type,
      );
      emit(
        state.copyWith(
          send: const SendNotificationSuccess(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          send: SendNotificationFailure(
            message: e.toString(),
          ),
        ),
      );
    }
  }
}
