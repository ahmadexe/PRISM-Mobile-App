part of '../home.dart';

class _Post extends StatelessWidget {
  final Post post;
  const _Post({required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        if (post.caption != null)
          Text(
            post.caption!,
            style: AppText.b1,
          ),
        Space.y1!,
        if (post.imageUrl != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              post.imageUrl!,
              width: double.infinity,
              height: AppDimensions.normalize(150),
              fit: BoxFit.cover,
            ),
          ),
      ],
    );
  }
}
