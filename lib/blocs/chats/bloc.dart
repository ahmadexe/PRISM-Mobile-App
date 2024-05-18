import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

part 'data_provider.dart';
part 'adaptor.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  ChatsBloc() : super(ChatsInitial()) {
    on<ChatsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
