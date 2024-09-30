part of 'notifications.dart';

class _ScreenState extends ChangeNotifier {
  static _ScreenState s(BuildContext context, [listen = false]) =>
      Provider.of<_ScreenState>(context, listen: listen);

  int index = 0;
  void setIndex(int i) {
    index = i;
    notifyListeners();
  }
}
