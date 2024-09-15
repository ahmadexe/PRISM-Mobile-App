import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:iconsax/iconsax.dart';
import 'package:prism/blocs/auth/bloc.dart';
import 'package:prism/blocs/jobs/bloc.dart';
import 'package:prism/blocs/posts/bloc.dart';
import 'package:prism/configs/configs.dart';
import 'package:prism/router/routes.dart';
import 'package:prism/static/app_statics.dart';
import 'package:prism/widgets/avatar.dart';
import 'package:prism/widgets/core/bottom_bar/bottom_bar.dart';
import 'package:prism/widgets/core/error/error.dart';
import 'package:prism/widgets/design/input/app_text_field.dart';
import 'package:prism/widgets/job/job_card.dart';
import 'package:prism/widgets/posts/posts_placeholder.dart';
import 'package:prism/widgets/posts/post.dart';
import 'package:provider/provider.dart';

part '_state.dart';

part 'widgets/_body.dart';
part 'widgets/_drawer.dart';
part 'widgets/_body_service_provider.dart';

part 'static/_form_keys.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);
    final auth = BlocProvider.of<AuthBloc>(context, listen: true).state;
    final user = auth.user!;

    return ChangeNotifierProvider<_ScreenState>(
      create: (_) => _ScreenState(),
      child: user.isServiceProvider ? const _BodyServiceProvider() : const _Body(),
    );
  }
}
