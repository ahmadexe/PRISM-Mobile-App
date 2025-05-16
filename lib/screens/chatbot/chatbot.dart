import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:agenix/agenix.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prism/blocs/auth/bloc.dart';
import 'package:prism/blocs/blockchain/bloc.dart';
import 'package:prism/blocs/lens/bloc.dart';
import 'package:prism/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:prism/providers/media_provider.dart';
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
