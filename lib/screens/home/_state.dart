part of 'home.dart';

class _ScreenState extends ChangeNotifier {
  static _ScreenState s(BuildContext context, [listen = false]) =>
      Provider.of<_ScreenState>(context, listen: listen);

  final formKey = GlobalKey<FormBuilderState>();
  final commentFormKey = GlobalKey<FormBuilderState>();

  bool showPostArrow = false;
  void setPostArrow(bool val) {
    showPostArrow = val;
    notifyListeners();
  }
}
