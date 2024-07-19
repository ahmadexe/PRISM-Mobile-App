part of '../bloc.dart';

class SearchState extends Equatable {
  static bool match(AuthState a, AuthState b) => a.search != b.search;

  final String? message;
  final List<AuthData>? users;

  const SearchState({
    this.message,
    this.users,
  });

  @override
  List<Object?> get props => [message, users];
}

class SearchDefault extends SearchState {
  const SearchDefault();
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

class SearchSuccess extends SearchState {
  const SearchSuccess({required List<AuthData> users}) : super(users: users);
}

class SearchFailure extends SearchState {
  const SearchFailure({
    required String message,
  }) : super(message: message);
}
