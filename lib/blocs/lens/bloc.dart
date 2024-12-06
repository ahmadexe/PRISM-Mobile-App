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
part 'repository.dart';
part 'data_provider.dart';
part '_static.dart';

part 'state/_skill_extraction.dart';
part 'state/_response.dart';
part 'state/_key_words.dart';
part 'state/_analyze_image.dart';

class LensBloc extends Bloc<LensEvent, LensState> {
  LensBloc() : super(const LensDefault()) {
    on<GenerateContent>(_onGenerateContent);
    on<ExtractSkills>(_extractSkills);
    on<ExtractKeywords>(_extractKeywords);
    on<AnalyzeImage>(_onAnalyzeImage);
  }

  late final LensService _service;

  void init() {
    final key = dotenv.env['GEMINI_API_KEY'];
    if (key == null || key.isEmpty) {
      throw Exception('API key not found');
    }

    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: key);
    _service = LensService(model: model);
    debugPrint('LensBloc initialized');
  }

  Future<void> _onAnalyzeImage(
      AnalyzeImage event, Emitter<LensState> emit) async {
    emit(state.copyWith(analyzeImage: const AnalyzeImageLoading()));
    try {
      final Uint8List image = event.inputImage;
      const String prompt = "Analyze the image and output the result, describe the image in great detail. Don't include any additional text.";

      final DataPart dataPart = DataPart('image/jpeg', image);

      final content = await _service.generateContentFromImage(
        prompt: prompt,
        dataPart: dataPart,
      );

      if (content == null) {
        throw Exception('Failed to analyze image');
      }

      final List<String> data = [content, ...state.data ?? []];

      emit(
        state.copyWith(
          analyzeImage: const AnalyzeImageSuccess(),
          data: data,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          analyzeImage: AnalyzeImageFailure(
            error: e.toString(),
          ),
        ),
      );
    }
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

  Future<void> _extractKeywords(
    ExtractKeywords event,
    Emitter<LensState> emit,
  ) async {
    emit(
      state.copyWith(
        keywords: const KeywordsExtractionLoading(),
      ),
    );
    try {
      final raw = event.inputText;
      final prompt =
          '''$raw \nUse this text and output keywords, the output text should only have keywords seperated by comma, e.g. keyword1,keyword2,keyword3 It should have no additional text.''';

      final response =
          await _service.generateContentFromText(prompt: prompt) ?? '';
      List<String>? keywords;
      if (response.isNotEmpty) {
        keywords = response.split(',').map((e) => e.trim()).toList();
      }

      emit(
        state.copyWith(
          keywords: KeywordsExtractionSuccess(keywords: keywords ?? []),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          keywords: KeywordsExtractionFailure(
            error: e.toString(),
          ),
        ),
      );
    }
  }
}
