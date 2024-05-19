import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:prism/blocs/auth/bloc.dart';
import 'package:prism/blocs/chats/bloc.dart';

import 'package:prism/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:prism/models/auth/auth_data.dart';
import 'package:prism/models/chat/message.dart';
import 'package:prism/widgets/avatar.dart';
import 'package:prism/widgets/design/input/app_text_field.dart';
import 'package:provider/provider.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

part 'static/_form_keys.dart';

part '_state.dart';
part '_data.dart';

part 'widgets/_body.dart';
part 'widgets/_message_tile.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);

    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final receiver = args['receiver'] as AuthData;

    return ChangeNotifierProvider<_ScreenState>(
      create: (_) => _ScreenState(),
      child: _Body(
        receiver: receiver,
      ),
    );
  }
}
