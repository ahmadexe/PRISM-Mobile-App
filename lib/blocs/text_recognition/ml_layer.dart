part of 'bloc.dart';

class TextRecognitionModel {
  static final textRecognizer =
      TextRecognizer(script: TextRecognitionScript.latin);

  static Future<String> recognizeText(InputImage inputImage) async {
    try {
      final recognisedText = await textRecognizer.processImage(inputImage);
      return recognisedText.text;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Error recognizing text');
    }
  }
}
