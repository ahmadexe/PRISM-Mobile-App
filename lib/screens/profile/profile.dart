import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:prism/blocs/auth/bloc.dart';
import 'package:prism/blocs/posts/bloc.dart';
import 'package:prism/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:prism/models/auth/auth_data.dart';
import 'package:prism/models/post/post.dart';
import 'package:prism/router/routes.dart';
import 'package:prism/static/app_statics.dart';
import 'package:prism/widgets/avatar.dart';
import 'package:prism/widgets/core/bottom_bar/bottom_bar.dart';
import 'package:prism/widgets/core/error/error.dart';
import 'package:prism/widgets/info_tile.dart';
import 'package:provider/provider.dart';

part '_state.dart';

part 'widgets/_body.dart';
part 'widgets/_tab.dart';
part 'widgets/_post_meta_card.dart';
part 'widgets/_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);

    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    final userId = args?['userId'] as String?;

    return ChangeNotifierProvider<_ScreenState>(
      create: (_) => _ScreenState(),
      child: _Body(
        userId: userId,
      ),
    );
  }
}
