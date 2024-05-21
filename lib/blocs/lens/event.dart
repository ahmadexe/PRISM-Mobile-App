part of 'bloc.dart';

sealed class LensEvent extends Equatable {
  const LensEvent();

  @override
  List<Object> get props => [];
}

class GenerateContent extends LensEvent {
  final LensMessage prompt;
  final Uint8List? image;

  const GenerateContent({
    required this.prompt,
    this.image,
  });
}

class ExtractSkills extends LensEvent {
  final InputImage inputImage;
  const ExtractSkills({
    required this.inputImage,
  });
}