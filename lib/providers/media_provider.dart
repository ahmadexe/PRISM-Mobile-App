import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MediaProvider extends ChangeNotifier {
  static MediaProvider s(BuildContext context, [listen = false]) =>
      Provider.of<MediaProvider>(context, listen: listen);

  XFile? media;

  InputImage? inputImage;

  void pickMedia(ImageSource source, [bool generateInputImg = false]) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      media = image;
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
}
