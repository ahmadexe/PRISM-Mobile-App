part of 'bloc.dart';

sealed class LensEvent extends Equatable {
  const LensEvent();

  @override
  List<Object> get props => [];
}

class GenerateContent extends LensEvent {
  final LensMessage prompt;
  final String? chainData;
  final Uint8List? image;

  const GenerateContent({required this.prompt, this.image, this.chainData});
}

class ExtractSkills extends LensEvent {
  final InputImage inputImage;
  const ExtractSkills({
    required this.inputImage,
  });
}

class ExtractKeywords extends LensEvent {
  final String inputText;
  const ExtractKeywords({
    required this.inputText,
  });
}

class AnalyzePost extends LensEvent {
  final Uint8List? inputImage;
  final String? text;
  const AnalyzePost({
    this.inputImage,
    this.text,
  });
}

class SuperchargeLensToggle extends LensEvent {
  final List<DataModel> data;
  const SuperchargeLensToggle({
    required this.data,
  });
}
