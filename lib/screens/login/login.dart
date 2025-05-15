import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:prism/blocs/auth/bloc.dart';
import 'package:prism/blocs/jobs/bloc.dart';
import 'package:prism/blocs/lens/bloc.dart';
import 'package:prism/blocs/notifications/bloc.dart';
import 'package:prism/blocs/posts/bloc.dart';

import 'package:prism/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:prism/router/routes.dart';
import 'package:prism/static/app_statics.dart';
import 'package:prism/widgets/core/snackbar/custom_snackbar.dart';
import 'package:prism/widgets/design/buttons/app_button.dart';
import 'package:prism/widgets/design/input/app_text_field.dart';
import 'package:prism/widgets/headless/divider.dart';
import 'package:provider/provider.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

part 'static/_form_data.dart';
part 'static/_form_keys.dart';

part '_state.dart';

part 'widgets/_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return ChangeNotifierProvider<_ScreenState>(
      create: (_) => _ScreenState(),
      child: const _Body(),
    );
  }
}
