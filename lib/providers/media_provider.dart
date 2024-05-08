import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MediaProvider extends ChangeNotifier {
  static MediaProvider s(BuildContext context, [listen = false]) =>
      Provider.of<MediaProvider>(context, listen: listen);

  XFile? media;

  void pickMedia(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      media = image;
      notifyListeners();
    }
  }

  void removeMedia() {
    media = null;
    notifyListeners();
  }
}
