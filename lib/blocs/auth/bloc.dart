import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prism/models/auth_data.dart';
import 'package:prism/services/api.dart';

part 'event.dart';
part 'state.dart';
part 'repository.dart';
part 'data_provider.dart';
part 'states/_register.dart';
part 'states/_login.dart';
part 'states/_init.dart';
part 'states/_logout.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthDefault()) {
    on<AuthRegister>(_register);
    on<AuthLogin>(_login);
    on<AuthInit>(_init);
    on<AuthLogout>(_logout);
  }

  final _repo = _AuthRepository();
  late StreamSubscription<User?> listener;

  void _register(AuthRegister event, Emitter<AuthState> emit) async {
    emit(state.copyWith(register: const AuthRegisterLoading()));
    try {
      final user = await _repo.register(
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
      final user = await _repo.login(
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
      final profile = await _repo.getUser(event.user);
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
      await _repo.logout();
      emit(
        state.copyWith(
          user: null,
          logout: const AuthLogoutSuccess(),
          login: const AuthLoginDefault(),
          register: const AuthRegisterDefault(),
          init: const AuthInitDefault()
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
}
