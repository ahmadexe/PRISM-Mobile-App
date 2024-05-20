part of 'bloc.dart';

sealed class LensEvent extends Equatable {
  const LensEvent();

  @override
  List<Object> get props => [];
}

class GenerateContent extends LensEvent {
  final String prompt;
  final Uint8List? image;

  const GenerateContent({
    required this.prompt,
    this.image,
  });
}