part of '../bloc.dart';

class DataState extends Equatable {
  static bool match(AuthState a, AuthState b) => a.data != b.data;
  final String? message;

  const DataState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class DataDefault extends DataState {
  const DataDefault();
}

class DataLoading extends DataState {
  const DataLoading();
}

class DataSuccess extends DataState {
  const DataSuccess();
}

class DataFailure extends DataState {
  const DataFailure({
    required String message,
  }) : super(message: message);
}
