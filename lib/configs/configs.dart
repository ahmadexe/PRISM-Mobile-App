import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';

part '_app_core_theme.dart';
part '_app_dimensions.dart';
part '_app_theme.dart';
part '_app_typography.dart';
part '_app_typography_ext.dart';
part '_core_theme.dart';
part '_int_ext.dart';
part '_space.dart';
part '_space_ext.dart';
part '_string_ext.dart';
part '_ui.dart';
part '_ui_props.dart';

class App {
  static bool? isLtr;
  static bool showAds = false;

  static init(BuildContext context) async {
    UI.init(context);
    AppDimensions.init();
    AppTheme.init(context);
    UIProps.init(context);
    Space.init(context);
    AppText.init(context);
    isLtr = Directionality.of(context) == TextDirection.ltr;
  }

  static String id() {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();

    return String.fromCharCodes(
      Iterable.generate(
        18,
        (_) => chars.codeUnitAt(
          rnd.nextInt(chars.length),
        ),
      ),
    );
  }
}
