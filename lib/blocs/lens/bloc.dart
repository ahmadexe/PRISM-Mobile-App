import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:prism/models/lens/lens_message.dart';
import 'package:prism/services/lens_service.dart';

part 'event.dart';
part 'state.dart';
part 'adaptor.dart';
part 'data_provider.dart';

class LensBloc extends Bloc<LensEvent, LensState> {
  LensBloc() : super(const LensDefault()) {
    on<GenerateContent>(_onGenerateContent);
  }

  late final LensService _service;

  void init() {
    final key = dotenv.env['GEMINI_API_KEY'];
    if (key == null || key.isEmpty) {
      throw Exception('API key not found');
    }

    final model = GenerativeModel(model: 'gemini-pro', apiKey: key);
    _service = LensService(model: model);
    debugPrint('LensBloc initialized');
  }

  Future<void> _onGenerateContent(
    GenerateContent event,
    Emitter<LensState> emit,
  ) async {
    emit(state.copyWith(messages: [event.prompt, ...state.messages ?? []]));
    emit(state.copyWith(response: const LensLoading()));
    try {
      final content = event.image != null
          ? await _service.generateContentFromImage(
              prompt: event.prompt.message,
              dataPart: DataPart('image/jpeg', event.image!),
            )
          : await _service.generateContentFromText(
              prompt: event.prompt.message);
      if (content == null) {
        throw Exception('Failed to generate content');
      }
      final message = LensMessage(
        message: content,
        isFromLens: true,
        time: DateTime.now(),
      );
      emit(state.copyWith(messages: [message, ...state.messages ?? []]));
      debugPrint('LensBloc success $content');
      emit(state.copyWith(response: const LensSuccess()));
    } catch (e) {
      debugPrint('LensBloc error: $e');
      emit(state.copyWith(
        response: LensFailure(error: e.toString()),
      ));
    }
  }
}
