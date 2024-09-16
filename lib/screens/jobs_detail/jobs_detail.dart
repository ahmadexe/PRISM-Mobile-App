import 'package:iconsax/iconsax.dart';
import 'package:prism/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:prism/models/job/job.dart';
import 'package:prism/widgets/avatar.dart';
import 'package:prism/widgets/design/buttons/app_button.dart';
import 'package:prism/widgets/headless/divider.dart';
import 'package:provider/provider.dart';

part '_state.dart';

part 'widgets/_body.dart';

class JobsDetailScreen extends StatelessWidget {
  const JobsDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final job = args['job'] as Job;

    return ChangeNotifierProvider<_ScreenState>(
      create: (_) => _ScreenState(
        job: job,
      ),
      child: const _Body(),
    );
  }
}
