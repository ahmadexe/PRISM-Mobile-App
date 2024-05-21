import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prism/models/auth/auth_data.dart';
import 'package:prism/services/api.dart';

part 'event.dart';
part 'state.dart';
part 'adaptor.dart';
part 'data_provider.dart';

part 'states/_register.dart';
part 'states/_login.dart';
part 'states/_init.dart';
part 'states/_logout.dart';
part 'states/_update.dart';
part 'states/_get_user.dart';
part 'states/_forgot_password.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthDefault()) {
    on<AuthRegister>(_register);
    on<AuthLogin>(_login);
    on<AuthInit>(_init);
    on<AuthLogout>(_logout);
    on<AuthUpdate>(_update);
    on<GetUserByIdEvent>(_getById);
    on<ForgotPassword>(_forgotPassword);
  }

  final _adaptor = _AuthAdaptor();
  late StreamSubscription<User?> listener;

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

      emit(
        state.copyWith(
          user: user,
          login: const AuthLoginSuccess(),
        ),
      );
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
      emit(state.copyWith(
        user: profile,
        init: const AuthInitSuccess(),
      ));
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
      emit(
        state.copyWith(
          user: null,
          logout: const AuthLogoutSuccess(),
          login: const AuthLoginDefault(),
          register: const AuthRegisterDefault(),
          init: const AuthInitDefault(),
          get: const GetUserDefault(),
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
    emit(state.copyWith(forgot: const ForgotPasswordLoading()));
    try {
      await _AuthDataProvider.forgotPassword(event.email);
      emit(state.copyWith(forgot: const ForgotPasswordSuccess()));
    } catch (e) {
      emit(state.copyWith(
        forgot: ForgotPasswordFailure(message: e.toString()),
      ));
    }
  }
}
