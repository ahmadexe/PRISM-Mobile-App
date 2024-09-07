import 'package:flutter/material.dart';
import 'package:prism/configs/configs.dart';

class TextExpander extends StatefulWidget {
  final String displayText;
  const TextExpander({super.key, required this.displayText});

  @override
  State<TextExpander> createState() => _TextExpanderState();
}

class _TextExpanderState extends State<TextExpander> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Text(
        isExpanded || widget.displayText.length < 100
            ? widget.displayText
            : '${widget.displayText.substring(0, 100)} \nRead more...',
        style: AppText.b2!.cl(Colors.grey),
      ),
    );
  }
}
