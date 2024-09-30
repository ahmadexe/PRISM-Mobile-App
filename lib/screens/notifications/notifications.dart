import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prism/blocs/jobs/bloc.dart';
import 'package:prism/blocs/notifications/bloc.dart';
import 'package:prism/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:prism/models/notification/notification_model.dart';
import 'package:prism/widgets/core/bottom_bar/bottom_bar.dart';
import 'package:prism/widgets/core/error/error.dart';
import 'package:provider/provider.dart';

part '_state.dart';

part 'widgets/_body.dart';
part 'widgets/_notification_tile.dart';

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
