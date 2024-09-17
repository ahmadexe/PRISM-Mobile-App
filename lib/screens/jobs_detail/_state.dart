part of 'jobs_detail.dart';

class _ScreenState extends ChangeNotifier {
  final Job job;
  bool isJobLiked = false;
  _ScreenState({
    required this.job,
    required this.isJobLiked,
  });
  static _ScreenState s(BuildContext context, [listen = false]) =>
      Provider.of<_ScreenState>(context, listen: listen);
  
  void toggleLike() {
    isJobLiked = !isJobLiked;
    notifyListeners();
  }
}
