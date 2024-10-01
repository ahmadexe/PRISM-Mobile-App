import 'package:prism/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part '_state.dart';

part 'widgets/_body.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return ChangeNotifierProvider<_ScreenState>(
      create: (_) => _ScreenState(),
      child: const _Body(),
    );
  }
}
