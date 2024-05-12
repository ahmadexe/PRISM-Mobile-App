part of '../home.dart';

class _Post extends StatelessWidget {
  final Post post;
  final int index;
  const _Post({required this.post, required this.index});

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
                  Text(
                    post.userName,
                    style: AppText.b1bm,
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
        _MetaDataCounter(
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
