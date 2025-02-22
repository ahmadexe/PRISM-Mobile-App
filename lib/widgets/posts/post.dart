import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prism/blocs/auth/bloc.dart';
import 'package:prism/blocs/posts/bloc.dart';
import 'package:prism/configs/configs.dart';
import 'package:prism/models/post/post.dart';
import 'package:prism/router/routes.dart';
import 'package:prism/widgets/avatar.dart';
import 'package:prism/widgets/design/buttons/app_button.dart';
import 'package:prism/widgets/posts/meta_data_counter.dart';
import 'package:prism/widgets/info_tile.dart';
import 'package:prism/widgets/text_expander.dart';

part '_report_modal.dart';
part '_type_modal.dart';
part '_data.dart';

class Post extends StatelessWidget {
  final PostData post;
  final int index;
  const Post({
    super.key,
    required this.post,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final currentProfile = authBloc.state.user!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (currentProfile.id == post.userId) {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.profile,
                        );
                      } else {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.profile,
                          arguments: {
                            'userId': post.userId,
                          },
                        );
                      }
                    },
                    child: Avatar(
                      imageUrl: post.userProfilePic,
                    ),
                  ),
                  Space.x2!,
                  GestureDetector(
                    onTap: () => debugPrint('username tapped'),
                    child: Text(
                      post.userName,
                      style: AppText.b1bm,
                    ),
                  ),
                ],
              ),
            ),
            InfoTile(
              domain: post.category,
              iconOnly: true,
            ),
            Space.x!,
            GestureDetector(
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (_) => _ReportModal(
                  postId: post.id,
                  imageUrl: post.imageUrl ?? '',
                ),
              ),
              child: const Icon(Icons.more_vert),
            )
          ],
        ),
        Space.y1!,
        Text(
          post.title,
          style: AppText.b1b,
        ),
        if (post.description != null && post.description!.isNotEmpty)
          TextExpander(displayText: post.description!),
        Space.y1!,
        if (post.imageUrl != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: post.imageUrl!,
              width: double.infinity,
              height: AppDimensions.normalize(150),
              fit: BoxFit.cover,
            ),
          ),
        Space.y1!,
        MetaDataCounter(
          post: post,
          index: index,
        ),
        const Divider(
          thickness: 0.5,
        )
      ],
    );
  }
}
