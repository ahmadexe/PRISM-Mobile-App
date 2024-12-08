part of 'settings.dart';

class _ScreenState extends ChangeNotifier {
  static _ScreenState s(BuildContext context, [listen = false]) =>
      Provider.of<_ScreenState>(context, listen: listen);

  bool? isSharingData;
  void setIsSharingData(bool val) {
    isSharingData = val;
    notifyListeners();
  }
}
