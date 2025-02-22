import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prism/models/auth/auth_data.dart';
import 'package:prism/services/api.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'event.dart';
part 'state.dart';
part 'repository.dart';
part 'data_provider.dart';

part 'states/_register.dart';
part 'states/_login.dart';
part 'states/_init.dart';
part 'states/_logout.dart';
part 'states/_update.dart';
part 'states/_get_user.dart';
part 'states/_forgot_password.dart';
part 'states/_toggle_follow.dart';
part 'states/_search.dart';
part 'states/_service_provider.dart';
part 'states/_device_token.dart';
part 'states/_data.dart';
part 'states/_supercharge.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthDefault()) {
    on<AuthRegister>(_register);
    on<AuthLogin>(_login);
    on<AuthInit>(_init);
    on<AuthLogout>(_logout);
    on<AuthUpdate>(_update);
    on<GetUserByIdEvent>(_getById);
    on<ForgotPassword>(_forgotPassword);
    on<ToggleFollowEvent>(_toggleFollow);
    on<SearchEvent>(_search);
    on<SubscribeToSearch>(_subscribeToSearch);
    on<ToggleServiceProviderEvent>(_toggleServiceProvider);
    on<UpdateDeviceToken>(_updateDeviceToken);
    on<ToggleShareData>(_onToggleShareData);
    on<ToggleSupercharge>(_onToggleSupercharge);
  }

  final _adaptor = _AuthAdaptor();
  late StreamSubscription<User?> listener;

  Future<void> _onToggleSupercharge(
      ToggleSupercharge event, Emitter<AuthState> emit) async {
    emit(state.copyWith(supercharge: const SuperchargeLoading()));
    try {
      await _AuthDataProvider.toggleIsSupercharged(event.id);
      final user =
          state.user!.copyWith(isSupercharged: !state.user!.isSupercharged);
      emit(state.copyWith(supercharge: const SuperchargeSuccess(), user: user));
    } catch (e) {
      emit(state.copyWith(
          supercharge: SuperchargeFailure(message: e.toString())));
    }
  }

  Future<void> _onToggleShareData(
      ToggleShareData event, Emitter<AuthState> emit) async {
    emit(state.copyWith(data: const DataLoading()));
    try {
      await _AuthDataProvider.toggleIsSharingData(event.id);
      emit(state.copyWith(data: const DataSuccess()));
    } catch (e) {
      emit(state.copyWith(data: DataFailure(message: e.toString())));
    }
  }

  void _register(AuthRegister event, Emitter<AuthState> emit) async {
    emit(state.copyWith(register: const AuthRegisterLoading()));
    try {
      final user = await _adaptor.register(
        event.email,
        event.password,
        event.payload,
      );

      emit(
        state.copyWith(
          user: user,
          register: const AuthRegisterSuccess(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          register: AuthRegisterFailure(
            message: e.toString(),
          ),
        ),
      );
    }
  }

  void _login(AuthLogin event, Emitter<AuthState> emit) async {
    emit(state.copyWith(login: const AuthLoginLoading()));
    try {
      final user = await _adaptor.login(
        event.email,
        event.password,
      );

      final channel = _AuthDataProvider.initSearchChannel(user.id);

      emit(
        state.copyWith(
          user: user,
          login: const AuthLoginSuccess(),
          channel: channel,
        ),
      );
      add(const SubscribeToSearch());
    } catch (e) {
      emit(
        state.copyWith(
          login: AuthLoginFailure(
            message: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _init(AuthInit event, Emitter<AuthState> emit) async {
    emit(state.copyWith(init: const AuthInitLoading()));
    try {
      if (event.user == null) {
        emit(state.copyWith(
          init: const AuthInitFailure(message: 'User not found'),
        ));
        return;
      }
      final profile = await _adaptor.getUser(event.user);

      final channel = _AuthDataProvider.initSearchChannel(profile.id);

      emit(state.copyWith(
        user: profile,
        init: const AuthInitSuccess(),
        channel: channel,
      ));

      add(const SubscribeToSearch());
    } catch (e) {
      emit(state.copyWith(
        init: AuthInitFailure(message: e.toString()),
      ));
    }
  }

  Future<void> _logout(AuthLogout event, Emitter<AuthState> emit) async {
    emit(state.copyWith(logout: const AuthLogoutLoading()));
    try {
      await _adaptor.logout();
      state.channel?.sink.close();

      emit(
        state.copyWith(
          user: null,
          logout: const AuthLogoutSuccess(),
          login: const AuthLoginDefault(),
          register: const AuthRegisterDefault(),
          init: const AuthInitDefault(),
          get: const GetUserDefault(),
          search: const SearchDefault(),
          follow: const ToggleFollowDefault(),
          serviceProvider: const ServiceProviderToggleDefault(),
          token: const TokenDefault(),
          channel: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          logout: AuthLogoutFailure(message: e.toString()),
        ),
      );
    }
  }

  Future<void> _update(AuthUpdate event, Emitter<AuthState> emit) async {
    emit(state.copyWith(update: const AuthUpdateLoading()));
    try {
      final user = await _adaptor.update(
        event.userData,
        event.bannerImage,
        event.profileImage,
      );

      emit(
        state.copyWith(
          user: user,
          update: const AuthUpdateSuccess(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          update: AuthUpdateFailure(
            message: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _getById(GetUserByIdEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(get: const GetUserLoading()));
    try {
      final user = await _AuthDataProvider.getUserById(event.id);
      emit(state.copyWith(
        get: GetUserSuccess(user: user),
      ));
    } catch (e) {
      emit(state.copyWith(
        get: GetUserFailure(message: e.toString()),
      ));
    }
  }

  Future<void> _forgotPassword(
    ForgotPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        forgot: const ForgotPasswordLoading(),
      ),
    );
    try {
      await _AuthDataProvider.forgotPassword(event.email);
      emit(
        state.copyWith(
          forgot: const ForgotPasswordSuccess(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          forgot: ForgotPasswordFailure(
            message: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _toggleFollow(
    ToggleFollowEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        follow: const ToggleFollowLoading(),
      ),
    );
    try {
      final currentUser = state.user!;
      final otherUser = state.get.user!;

      if (currentUser.following.contains(otherUser.id)) {
        currentUser.following.remove(otherUser.id);
        otherUser.followers.remove(currentUser.id);
      } else {
        currentUser.following.add(otherUser.id);
        otherUser.followers.add(currentUser.id);
      }

      emit(state.copyWith(
        user: currentUser,
        get: GetUserSuccess(user: otherUser),
      ));

      await _AuthDataProvider.toggleFollow(event.to, event.from);
      emit(
        state.copyWith(
          follow: const ToggleFollowSuccess(),
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        follow: ToggleFollowFailure(
          message: e.toString(),
        ),
      ));
    }
  }

  Future<void> _search(SearchEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(search: const SearchLoading()));
    try {
      final query = event.query;
      if (query.isEmpty) {
        emit(state.copyWith(search: const SearchDefault()));
        return;
      }
      final id = state.user!.id;
      final channel = state.channel!;
      _adaptor.sendSearchQuery(channel, query, id);
    } catch (e) {
      emit(state.copyWith(
        search: SearchFailure(message: e.toString()),
      ));
    }
  }

  Future<void> _subscribeToSearch(
    SubscribeToSearch event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await emit.forEach(
        state.channel!.stream.asBroadcastStream(),
        onData: (data) {
          final raw = data as String;
          final normalized = json.decode(raw) as Map<String, dynamic>;

          final usersRaw = normalized['data'] as List<dynamic>? ?? [];

          final users = usersRaw.map((e) => AuthData.fromMap(e)).toList();

          return state.copyWith(search: SearchSuccess(users: users));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        search: SearchFailure(message: e.toString()),
      ));
    }
  }

  void _toggleServiceProvider(
    ToggleServiceProviderEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(serviceProvider: const ServiceProviderToggleLoading()));
    try {
      AuthData user = state.user!;
      await _AuthDataProvider.switchProfileMode(event.id);
      user = user.copyWith(isServiceProvider: !user.isServiceProvider);

      emit(
        state.copyWith(
          user: user,
          serviceProvider: const ServiceProviderToggleSuccess(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          serviceProvider: ServiceProviderToggleFailure(
            message: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _updateDeviceToken(
    UpdateDeviceToken event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        token: const TokenLoading(),
      ),
    );
    try {
      await _AuthDataProvider.updateDeviceToken(event.userId);
      emit(
        state.copyWith(
          token: const TokenSuccess(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          token: TokenFailure(message: e.toString()),
        ),
      );
    }
  }
}
