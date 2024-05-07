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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
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
            InfoTile(
              domain: post.category,
              iconOnly: true,
            ),
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
          Image.network(
            post.imageUrl!,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
      ],
    );
  }
}
