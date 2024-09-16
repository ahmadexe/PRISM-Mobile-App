// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'jobs_detail.dart';

class _ScreenState extends ChangeNotifier {
  final Job job;
  _ScreenState({
    required this.job,
  });
  static _ScreenState s(BuildContext context, [listen = false]) =>
      Provider.of<_ScreenState>(context, listen: listen);
}
