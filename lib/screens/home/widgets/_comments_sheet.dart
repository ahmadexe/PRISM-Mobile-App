part of '../home.dart';

class _CommentsSheet extends StatelessWidget {
  final Post post;
  const _CommentsSheet({required this.post});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);

    return Container(
      height: media.height * .95,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.c.backgroundSub,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            AppDimensions.normalize(10),
          ),
        ),
      ),
      child: Padding(
        padding: Space.all(),
        child: Column(
          children: [
            Container(
              width: media.width * .1,
              height: AppDimensions.normalize(3),
              decoration: BoxDecoration(
                color: AppTheme.c.grey,
                borderRadius: BorderRadius.circular(
                  AppDimensions.normalize(5),
                ),
              ),
            ),
            Space.y!,
            Text(
              'Comments',
              style: AppText.b1bm,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return Padding(
                    padding: Space.v!,
                    child: ListTile(
                      leading: Avatar(
                        imageUrl: comment.userProfilePic,
                      ),
                      title: Text(comment.userName),
                      subtitle: Text(comment.content),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: Space.v!,
              child: Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      hint: 'Add a comment',
                      onChanged: (val) {},
                      name: 'name',
                      type: FieldType.secondary,
                    ),
                  ),
                  Space.x1!,
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Iconsax.send_2,
                      size: AppDimensions.normalize(10),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
