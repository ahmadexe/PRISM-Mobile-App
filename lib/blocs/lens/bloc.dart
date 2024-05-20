import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:prism/services/lens_service.dart';

part 'event.dart';
part 'state.dart';
part 'adaptor.dart';
part 'data_provider.dart';

class LensBloc extends Bloc<LensEvent, LensState> {
  LensBloc() : super(LensInitial()) {
    on<GenerateContent>(_onGenerateContent);
  }

  late final LensService _service;

  void init() {
    final key = dotenv.env['ENV_VARIABLE'];
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
    emit(const LensLoading());
    try {
      final content = event.image != null
          ? await _service.generateContentFromImage(
              prompt: event.prompt,
              dataPart: DataPart('image/jpeg',event.image!),
            )
          : await _service.generateContentFromText(prompt: event.prompt);

      emit(LensSuccess(content: content!));
    } catch (e) {
      emit(LensFailure(error: e.toString()));
    }
  }
}
