import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:prism/configs/configs.dart';
import 'package:prism/models/post/post.dart';
import 'package:prism/widgets/avatar.dart';
import 'package:prism/widgets/design/posts/meta_data_counter.dart';
import 'package:prism/widgets/info_tile.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Avatar(
                    imageUrl: post.userProfilePic,
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
              onTap: () {},
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

class TextExpander extends StatefulWidget {
  final String displayText;
  const TextExpander({super.key, required this.displayText});

  @override
  State<TextExpander> createState() => _TextExpanderState();
}

class _TextExpanderState extends State<TextExpander> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Text(
        isExpanded ? widget.displayText : 'Read more...',
      ),
    );
  }
}
