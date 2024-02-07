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

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthDefault()) {
    on<AuthRegister>(_register);
    on<AuthLogin>(_login);
  }

  final _repo = _AuthRepository();

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
}
