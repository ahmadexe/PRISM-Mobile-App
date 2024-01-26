import 'package:flutter/material.dart';
import 'package:prism/configs/configs.dart';

class AppDivider extends StatelessWidget {
  final String? text;
  const AppDivider({this.text, super.key});

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Padding(
      padding: Space.vf(),
      child: text == null
          ? Divider(color: AppTheme.c.white!.withOpacity(.5), thickness: 1)
          : Row(
              children: [
                Expanded(
                  child: Divider(
                    color: AppTheme.c.white!.withOpacity(.5),
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: Space.hf(),
                  child: Text(
                    text!,
                    style: AppText.l2bm,
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: AppTheme.c.white!.withOpacity(.5),
                    thickness: 1,
                  ),
                ),
              ],
            ),
    );
  }
}
