import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

part 'event.dart';
part 'state.dart';
part 'ml_layer.dart';

class TextRecognitionBloc
    extends Bloc<TextRecognitionEvent, TextRecognitionState> {
  TextRecognitionBloc() : super(const TextRecognitionInitial()) {
    on<RecognizeTextEvent>(_recognizeText);
    on<ClearDataEvent>(_clearData);
  }

  void _recognizeText(
      RecognizeTextEvent event, Emitter<TextRecognitionState> emit) async {
    emit(
      const TextRecognitionLoading(),
    );
    try {
      final text = await TextRecognitionModel.recognizeText(event.inputImage);
      emit(
        TextRecognitionSuccess(text: text),
      );
      debugPrint('Recognized text: $text');
    } catch (e) {
      emit(
        TextRecognitionFailure(
          error: e.toString(),
        ),
      );
    }
  }

  void _clearData(ClearDataEvent event, Emitter<TextRecognitionState> emit) {
    emit(
      const TextRecognitionInitial(),
    );
  }
}
