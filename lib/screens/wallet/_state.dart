part of 'wallet.dart';

class _ScreenState extends ChangeNotifier {
  static _ScreenState s(BuildContext context, [listen = false]) =>
      Provider.of<_ScreenState>(context, listen: listen);

  bool isShowingMainData = true;
  void toggleMainData() {
    isShowingMainData = !isShowingMainData;
    notifyListeners();
  }
}
