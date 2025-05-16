import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MediaProvider extends ChangeNotifier {
  static MediaProvider s(BuildContext context, [listen = false]) =>
      Provider.of<MediaProvider>(context, listen: listen);

  XFile? media;
  InputImage? inputImage;

  XFile? mediaForLens;
  InputImage? inputImageForLens;

  void pickMedia(ImageSource source, MediaUsecase mediaUsecase,
      [bool generateInputImg = false]) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      switch (mediaUsecase) {
        case MediaUsecase.lens:
          mediaForLens = image;
          if (generateInputImg) {
            inputImageForLens = InputImage.fromFilePath(mediaForLens!.path);
          }
          break;
        case MediaUsecase.profile:
          media = image;
          if (generateInputImg) {
            inputImage = InputImage.fromFilePath(media!.path);
          }
          break;
      }
      notifyListeners();
    }
  }

  void setInputImage() {
    if (media == null) return;
    inputImage = InputImage.fromFilePath(media!.path);
    notifyListeners();
  }

  void removeMedia() {
    media = null;
    notifyListeners();
  }

  void removeInputImage() {
    inputImage = null;
    notifyListeners();
  }

  void clearMedia(MediaUsecase mediaUsecase) {
    switch (mediaUsecase) {
      case MediaUsecase.lens:
        mediaForLens = null;
        inputImageForLens = null;
        break;
      case MediaUsecase.profile:
        media = null;
        inputImage = null;
        break;
    }
    notifyListeners();
  }
}

enum MediaUsecase { lens, profile }
