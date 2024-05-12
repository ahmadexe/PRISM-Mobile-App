import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:iconsax/iconsax.dart';
import 'package:prism/blocs/auth/bloc.dart';
import 'package:prism/blocs/comments/bloc.dart';
import 'package:prism/blocs/posts/bloc.dart';
import 'package:prism/configs/configs.dart';
import 'package:prism/models/post/comment.dart';
import 'package:prism/models/post/post.dart';
import 'package:prism/router/routes.dart';
import 'package:prism/static/app_statics.dart';
import 'package:prism/widgets/avatar.dart';
import 'package:prism/widgets/core/bottom_bar/bottom_bar.dart';
import 'package:prism/widgets/core/error/error.dart';
import 'package:prism/widgets/design/input/app_text_field.dart';
import 'package:prism/widgets/info_tile.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

part '_state.dart';
part '_data.dart';

part 'widgets/_body.dart';
part 'widgets/_post.dart';
part 'widgets/_meta_data_counter.dart';
part 'widgets/_posts_placeholder.dart';
part 'widgets/_comments_sheet.dart';

part 'static/_form_keys.dart';

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
