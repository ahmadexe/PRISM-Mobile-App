import 'dart:convert';
import 'dart:typed_data';

import 'package:agenix/agenix.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart' as gemini;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:prism/models/auth/auth_data.dart';
import 'package:prism/models/data/data.dart';
import 'package:prism/services/api.dart';
import 'package:prism/services/lens_service.dart';
import 'package:uuid/uuid.dart';

part 'event.dart';

part 'state.dart';
part 'repository.dart';
part 'data_provider.dart';
part '_static.dart';

part 'state/_skill_extraction.dart';
part 'state/_response.dart';
part 'state/_key_words.dart';
part 'state/_analyze_post.dart';
part 'state/_supercharge.dart';

part 'tools/posts/_create_posts_tool.dart';

class LensBloc extends Bloc<LensEvent, LensState> {
  LensBloc() : super(const LensDefault()) {
    on<GenerateContent>(_onGenerateContent);
    on<ExtractSkills>(_extractSkills);
    on<ExtractKeywords>(_extractKeywords);
    on<AnalyzePost>(_onAnalyzeImage);
    on<SuperchargeLensToggle>(_superchargeLensToggle);
  }

  late final LensService _service;
  late final String convoId;
  late final AuthData _userData;

  void init(AuthData user) {
    final key = dotenv.env['GEMINI_API_KEY'];
    if (key == null || key.isEmpty) {
      throw Exception('API key not found');
    }

    Agent().init(
      dataStore: DataStore.firestoreDataStore(),
      llm: LLM.geminiLLM(
        apiKey: key,
        modelName: 'gemini-1.5-flash',
      ),
    );

    _service = LensService(
      model: gemini.GenerativeModel(model: 'gemini-1.5-flash', apiKey: key),
    );

    _userData = user;

    convoId = const Uuid().v4();

    ToolRegistry().registerTool(
      _CreatePostsTool(
        name: 'create_post_tool',
        description:
            'This tool is used whenever a user wants to create a post.',
        parameters: [
          ParameterSpecification(
            name: 'title',
            type: 'string',
            description: 'Title of the post',
            required: true,
          ),
          ParameterSpecification(
            name: 'description',
            type: 'string',
            description: 'Description of the post',
            required: true,
          ),
          ParameterSpecification(
            name: 'userId',
            type: 'string',
            description: 'This is the id of the user who is creating the post',
            required: true,
          ),
          ParameterSpecification(
            name: 'category',
            type: 'string',
            description:
                'This is the category of the post. The domain of the user will be used as the category, based on provided info, it can be Software, Technology, Business, Entertainment, etc.',
            required: true,
          ),
          ParameterSpecification(
            name: 'userName',
            type: 'string',
            description:
                'This is the name of the user who is creating the post',
            required: true,
          ),
          ParameterSpecification(
            name: 'userProfilePic',
            type: 'string',
            description:
                'This is the profile picture of the user who is creating the post',
            required: false,
          ),
        ],
      ),
    );

    debugPrint('LensBloc initialized');
  }

  Future<void> _superchargeLensToggle(
    SuperchargeLensToggle event,
    Emitter<LensState> emit,
  ) async {
    emit(state.copyWith(superchargeState: const SuperchargeLoading()));
    try {
      final data = event.data;
      final analyticalData = data.map((e) => e.data.join('\n')).join('\n');

      emit(
        state.copyWith(
          superchargeState: const SuperchargeSuccess(),
          analyticalData: analyticalData,
          isSupercharged: !state.isSupercharged,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          superchargeState: SuperchargeFailure(
            error: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _onAnalyzeImage(
      AnalyzePost event, Emitter<LensState> emit) async {
    emit(state.copyWith(analyzeImage: const AnalyzePostLoading()));
    try {
      List<String> data = [];
      if (event.inputImage != null) {
        final Uint8List image = event.inputImage!;

        const String prompt =
            "Analyze the image and output the result, describe the image in great detail. Don't include any additional text.";

        final gemini.DataPart dataPart = gemini.DataPart('image/jpeg', image);

        final content = await _service.generateContentFromImage(
          prompt: prompt,
          dataPart: dataPart,
        );

        if (content == null) {
          throw Exception('Failed to analyze image');
        }

        data = [content, ...state.data ?? []];
      }
      if (event.text != null) {
        final String text = event.text!;

        String prompt =
            "Analyze the text and output the result, describe the text in great detail. Don't include any additional text. This is the text: $text";

        final content = await _service.generateContentFromText(
          prompt: prompt,
        );

        if (content == null) {
          throw Exception('Failed to analyze text');
        }

        data = [content, ...state.data ?? []];
      }

      emit(
        state.copyWith(
          analyzeImage: const AnalyzePostSuccess(),
          data: data,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          analyzeImage: AnalyzePostFailure(
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
      String prompt = event.prompt.content;
      prompt =
          'For additional context this is the data of the user ${_userData.toString()}. The prompt is: $prompt';
      if (event.chainData != null && event.chainData!.isNotEmpty) {
        final chainData = event.chainData!;
        prompt =
            "$chainData\n Using this data, generate content. The output should be based on this provided data. If the question can not be answered by the current data, generate a response yourself. Use this data for analysis, generating insights, any useful information you can provide from this data. You are not restricted to this data only but you should use it as a starting point. $prompt";
      }

      final userMessage = AgentMessage(
        content: prompt,
        generatedAt: DateTime.now(),
        isFromAgent: false,
        imageData: event.image,
      );

      final response = await Agent()
          .generateResponse(convoId: convoId, userMessage: userMessage);

      emit(state.copyWith(messages: [response, ...state.messages ?? []]));
      emit(state.copyWith(response: const LensSuccess()));
      return;
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
