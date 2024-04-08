part of 'edit_profile.dart';

class _ScreenState extends ChangeNotifier {
  static _ScreenState s(BuildContext context, [listen = false]) =>
      Provider.of<_ScreenState>(context, listen: listen);

  final formKey = GlobalKey<FormBuilderState>();

  XFile? bannerImage;

  void pickBannerImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      bannerImage = image;
      notifyListeners();
    }
  }

  void removeBannerImage() {
    bannerImage = null;
    notifyListeners();
  }

  XFile? profileImage;

  void pickProfileImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      profileImage = image;
      notifyListeners();
    }
  }

  void removeProfileImage() {
    profileImage = null;
    notifyListeners();
  }
}
