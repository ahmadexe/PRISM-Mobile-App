import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:prism/blocs/auth/bloc.dart';
import 'package:prism/blocs/jobs/bloc.dart';
import 'package:prism/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:prism/router/routes.dart';
import 'package:prism/static/app_statics.dart';
import 'package:prism/widgets/core/bottom_bar/bottom_bar.dart';
import 'package:prism/widgets/core/error/error.dart';
import 'package:prism/widgets/design/input/app_text_field.dart';
import 'package:prism/widgets/job/job_card.dart';
import 'package:provider/provider.dart';

part '_state.dart';

part 'widgets/_body.dart';

class MyJobsScreen extends StatelessWidget {
  const MyJobsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return ChangeNotifierProvider<_ScreenState>(
      create: (_) => _ScreenState(),
      child: const _Body(),
    );
  }
}
