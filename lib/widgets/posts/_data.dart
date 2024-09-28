part of 'post.dart';

class _ReportItem {
  final String text;
  final String type;

  const _ReportItem({
    required this.text,
    required this.type,
  });
}

const List<_ReportItem> _reportItems = [
  _ReportItem(text: 'Violence, hate or harm', type: 'violence'),
  _ReportItem(text: 'Harassment or bullying', type: 'offensive'),
  _ReportItem(text: 'Graphic - Blood etc', type: 'gore'),
  _ReportItem(text: 'Nudity', type: 'nsfw'),
  _ReportItem(text: 'Sexual Activity', type: 'nsfw'),
  _ReportItem(text: 'Suicide', type: 'violence'),
];