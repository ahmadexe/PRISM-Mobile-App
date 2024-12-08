part of 'bloc.dart';

class AuthState extends Equatable {
  final WebSocketChannel? channel;

  final AuthData? user;
  final AuthInitState init;
  final AuthRegisterState register;
  final AuthLoginState login;
  final AuthLogoutState logout;
  final AuthUpdateState update;
  final GetUserState get;
  final ForgotPasswordState forgot;
  final ToggleFollowState follow;
  final SearchState search;
  final ServiceProviderToggleState serviceProvider;
  final TokenState token;
  final DataState data;

  const AuthState({
    this.channel,
    this.user,
    required this.init,
    required this.register,
    required this.login,
    required this.logout,
    required this.update,
    required this.get,
    required this.forgot,
    required this.follow,
    required this.search,
    required this.serviceProvider,
    required this.token,
    required this.data,
  });

  AuthState copyWith({
    WebSocketChannel? channel,
    AuthData? user,
    AuthInitState? init,
    AuthRegisterState? register,
    AuthLoginState? login,
    AuthLogoutState? logout,
    AuthUpdateState? update,
    GetUserState? get,
    ForgotPasswordState? forgot,
    ToggleFollowState? follow,
    SearchState? search,
    ServiceProviderToggleState? serviceProvider,
    TokenState? token,
    DataState? data,
  }) {
    return AuthState(
      channel: channel ?? this.channel,
      user: user ?? this.user,
      init: init ?? this.init,
      register: register ?? this.register,
      login: login ?? this.login,
      logout: logout ?? this.logout,
      update: update ?? this.update,
      get: get ?? this.get,
      forgot: forgot ?? this.forgot,
      follow: follow ?? this.follow,
      search: search ?? this.search,
      serviceProvider: serviceProvider ?? this.serviceProvider,
      token: token ?? this.token,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [
        channel,
        user,
        init,
        register,
        login,
        logout,
        update,
        get,
        forgot,
        follow,
        search,
        serviceProvider,
        token,
        data,
      ];
}

final class AuthDefault extends AuthState {
  const AuthDefault()
      : super(
          init: const AuthInitDefault(),
          register: const AuthRegisterDefault(),
          login: const AuthLoginDefault(),
          logout: const AuthLogoutDefault(),
          update: const AuthUpdateDefault(),
          get: const GetUserDefault(),
          forgot: const ForgotPasswordDefault(),
          follow: const ToggleFollowDefault(),
          search: const SearchDefault(),
          serviceProvider: const ServiceProviderToggleDefault(),
          token: const TokenDefault(),
          data: const DataDefault(),
        );
}
