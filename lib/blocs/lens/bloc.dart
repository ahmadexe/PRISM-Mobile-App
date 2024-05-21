import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:prism/models/lens/lens_message.dart';
import 'package:prism/services/lens_service.dart';

part 'event.dart';
part 'state.dart';
part 'adaptor.dart';
part 'data_provider.dart';
part '_static.dart';

part 'state/_skill_extraction.dart';
part 'state/_response.dart';

class LensBloc extends Bloc<LensEvent, LensState> {
  LensBloc() : super(const LensDefault()) {
    on<GenerateContent>(_onGenerateContent);
    on<ExtractSkills>(_extractSkills);
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
      emit(state.copyWith(response: const LensSuccess()));
    } catch (e) {
      emit(
        state.copyWith(
          messages: [kDefaulrErrorMessage, ...state.messages ?? []],
        ),
      );
      emit(state.copyWith(
        response: LensFailure(error: e.toString()),
      ));
    }
  }

  Future<void> _extractSkills(
    ExtractSkills event,
    Emitter<LensState> emit,
  ) async {
    emit(
      state.copyWith(
        skills: const SkillExtractionLoading(),
      ),
    );
    try {
      final raw = await _LensProvider.recognizeText(event.inputImage);
      List<String>? skills;
      if (raw.isNotEmpty) {
        final prompt =
            '''$raw \nUse this text and output skills, the output text should only have skills seperated by comma, e.g. skill1,skill2,skill3 It should have no additional text.''';
        final skillsRaw =
            await _service.generateContentFromText(prompt: prompt);
        if (skillsRaw == null) {
          throw Exception('Failed to extract skills');
        }

        skills = skillsRaw.split(',').map((e) => e.trim()).toList();
      }

      emit(
        state.copyWith(
          skills: SkillExtractionSuccess(skills: skills ?? []),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          skills: SkillExtractionFailure(
            error: e.toString(),
          ),
        ),
      );
    }
  }
}
