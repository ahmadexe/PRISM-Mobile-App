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

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(const NotificationsInitial()) {
    on<NotificationsEvent>((event, emit) {});
  }
}
