part of 'chat.dart';

class _ScreenState extends ChangeNotifier {
  static _ScreenState s(BuildContext context, [listen = false]) =>
      Provider.of<_ScreenState>(context, listen: listen);

  final formKey = GlobalKey<FormBuilderState>();

  bool isWriting = false;

  void setWriting(bool value) {
    isWriting = value;
    notifyListeners();
  }
}
