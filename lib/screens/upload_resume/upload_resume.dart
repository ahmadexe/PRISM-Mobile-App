import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prism/blocs/auth/bloc.dart';
import 'package:prism/blocs/lens/bloc.dart';
import 'package:prism/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:prism/providers/media_provider.dart';
import 'package:prism/router/routes.dart';
import 'package:prism/static/app_statics.dart';
import 'package:prism/widgets/core/snackbar/custom_snackbar.dart';
import 'package:prism/widgets/design/buttons/app_button.dart';
import 'package:prism/widgets/upload_image_board.dart';
import 'package:provider/provider.dart';

part '_state.dart';

part 'widgets/_body.dart';

class UploadResumeScreen extends StatelessWidget {
  const UploadResumeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return ChangeNotifierProvider<_ScreenState>(
      create: (_) => _ScreenState(),
      child: const _Body(),
    );
  }
}
