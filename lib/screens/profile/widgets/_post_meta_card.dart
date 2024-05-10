part of '../profile.dart';

class _PostMetaCard extends StatelessWidget {
  final Post post;
  const _PostMetaCard({required this.post});

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
        const Divider(
          thickness: 0.5,
        )
      ],
    );
  }
}
