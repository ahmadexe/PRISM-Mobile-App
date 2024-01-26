import 'package:flutter/foundation.dart';
import 'package:flutter_svg/svg.dart';

import 'package:prism/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:prism/static/app_statics.dart';
import 'package:provider/provider.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

part 'static/_form_data.dart';
part 'static/_form_keys.dart';

part '_state.dart';

part 'widgets/_body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return ChangeNotifierProvider<_ScreenState>(
      create: (_) => _ScreenState(),
      child: const _Body(),
    );
  }
}
