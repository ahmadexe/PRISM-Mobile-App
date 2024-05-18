import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:prism/blocs/auth/bloc.dart';
import 'package:prism/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:prism/router/routes.dart';
import 'package:prism/static/app_statics.dart';
import 'package:prism/widgets/design/input/app_text_field.dart';
import 'package:provider/provider.dart';

part '_state.dart';

part 'widgets/_body.dart';
part 'widgets/_setting_tile.dart';

part 'models/_list_data.dart';

part '_data.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return ChangeNotifierProvider<_ScreenState>(
      create: (_) => _ScreenState(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.logout is AuthLogoutSuccess) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.login,
              (route) => false,
            );
          }
        },
        child: const _Body(),
      ),
    );
  }
}
