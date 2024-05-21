import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prism/blocs/lens/bloc.dart';
import 'package:prism/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:prism/widgets/headless/full_screen_loader.dart';
import 'package:provider/provider.dart';

part '_state.dart';

part 'widgets/_body.dart';

class ResumeAnalysisScreen extends StatelessWidget {
  const ResumeAnalysisScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return ChangeNotifierProvider<_ScreenState>(
      create: (_) => _ScreenState(),
      child: const _Body(),
    );
  }
}
