import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:prism/blocs/auth/bloc.dart';
import 'package:prism/blocs/chats/bloc.dart';

import 'package:prism/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:prism/models/chat/conversation.dart';
import 'package:prism/router/routes.dart';
import 'package:prism/static/app_statics.dart';
import 'package:prism/widgets/avatar.dart';
import 'package:prism/widgets/core/error/error.dart';
import 'package:prism/widgets/design/input/app_text_field.dart';
import 'package:provider/provider.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

part 'static/_form_keys.dart';

part '_state.dart';
part '_data.dart';

part 'widgets/_body.dart';

part 'utils/_utils.dart';

class ConversationsScreen extends StatelessWidget {
  const ConversationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return ChangeNotifierProvider<_ScreenState>(
      create: (_) => _ScreenState(),
      child: const _Body(),
    );
  }
}
