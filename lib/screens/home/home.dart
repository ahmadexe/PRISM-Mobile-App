import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:prism/blocs/auth/bloc.dart';
import 'package:prism/configs/configs.dart';
import 'package:prism/models/post/post.dart';
import 'package:prism/screens/home/static/_static_data.dart';
import 'package:prism/widgets/avatar.dart';
import 'package:prism/widgets/core/bottom_bar/bottom_bar.dart';
import 'package:prism/widgets/design/input/app_text_field.dart';
import 'package:prism/widgets/info_tile.dart';
import 'package:provider/provider.dart';

part '_state.dart';

part 'widgets/_body.dart';
part 'widgets/_post.dart';
part 'widgets/_meta_data_counter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return ChangeNotifierProvider<_ScreenState>(
      create: (_) => _ScreenState(),
      child: const _Body(),
    );
  }
}
