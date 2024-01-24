import 'package:prism/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:prism/widgets/core/bottom_bar/bottom_bar.dart';
import 'package:provider/provider.dart';

part '_state.dart';

part 'widgets/_body.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return ChangeNotifierProvider<_ScreenState>(
      create: (_) => _ScreenState(),
      child: const _Body(),
    );
  }
}
