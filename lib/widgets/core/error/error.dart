import 'package:flutter/material.dart';
import 'package:prism/configs/configs.dart';
import 'package:prism/static/app_statics.dart';

class ErrorWarning extends StatelessWidget {
  final String title;
  final String message;
  const ErrorWarning({super.key, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AppStaticData.errorIcon,
          height: AppDimensions.normalize(55),
          width: AppDimensions.normalize(55),
        ),
        Space.y1!,
        Text(
          title,
          style: AppText.h2b,
        ),
        Space.y!,
        Text(
          message,
          style: AppText.b2,
        ),
      ],
    );
  }
}
