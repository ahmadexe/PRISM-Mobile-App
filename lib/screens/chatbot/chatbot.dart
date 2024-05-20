import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:prism/blocs/lens/bloc.dart';
import 'package:prism/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:prism/models/lens/lens_message.dart';
import 'package:prism/static/app_statics.dart';
import 'package:prism/widgets/design/input/app_text_field.dart';
import 'package:provider/provider.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

part 'static/_form_keys.dart';

part '_state.dart';
part '_data.dart';

part 'widgets/_body.dart';
part 'widgets/_no_messages.dart';
part 'widgets/_message_bubble.dart';
part 'widgets/_typing_indicator.dart';

part 'models/_bot_message.dart';

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return ChangeNotifierProvider<_ScreenState>(
      create: (_) => _ScreenState(),
      child: const _Body(),
    );
  }
}
