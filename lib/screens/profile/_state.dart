part of 'profile.dart';

class _ScreenState extends ChangeNotifier {
  static _ScreenState s(BuildContext context, [listen = false]) =>
      Provider.of<_ScreenState>(context, listen: listen);
  
  int tabIndex = 0;
  void setTabIndex(int index) {
    tabIndex = index;
    notifyListeners();
  }
}
