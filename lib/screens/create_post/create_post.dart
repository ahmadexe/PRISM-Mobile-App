import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:iconsax/iconsax.dart';
import 'package:prism/blocs/auth/bloc.dart';
import 'package:prism/blocs/posts/bloc.dart';
import 'package:prism/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:prism/providers/media_provider.dart';
import 'package:prism/widgets/avatar.dart';
import 'package:prism/widgets/core/snackbar/custom_snackbar.dart';
import 'package:prism/widgets/design/buttons/app_button.dart';
import 'package:prism/widgets/design/input/app_text_field.dart';
import 'package:prism/widgets/pick_image_modal.dart';
import 'package:provider/provider.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

part 'static/_form_keys.dart';

part '_state.dart';

part 'widgets/_body.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);

    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final initialText = args?['initialText'] as String?;

    return ChangeNotifierProvider<_ScreenState>(
      create: (_) => _ScreenState(),
      child: _Body(
        initialText: initialText,
      ),
    );
  }
}
