import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prism/blocs/auth/bloc.dart';
import 'package:prism/blocs/blockchain/bloc.dart';
import 'package:prism/blocs/transaction/transaction_bloc.dart';
import 'package:prism/blocs/wallet/wallet_bloc.dart';

import 'package:prism/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:prism/models/payment/transaction.dart';
import 'package:prism/static/app_statics.dart';
import 'package:prism/widgets/core/error/error.dart';
import 'package:prism/widgets/design/buttons/app_button.dart';
import 'package:prism/widgets/design/input/app_text_field.dart';
import 'package:prism/widgets/headless/full_screen_loader.dart';
import 'package:provider/provider.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

part 'static/_form_keys.dart';

part '_state.dart';

part 'widgets/_body.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return ChangeNotifierProvider<_ScreenState>(
      create: (_) => _ScreenState(),
      child: const _Body(),
    );
  }
}
