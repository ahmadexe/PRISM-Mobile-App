part of 'post.dart';

class _TypeModal extends StatelessWidget {
  final String postId;
  final String imageUrl;
  const _TypeModal({required this.postId, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    final postsBloc = BlocProvider.of<PostsBloc>(context);

    return Container(
      width: double.infinity,
      height: media.height * .8,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: AppTheme.c.fieldLight,
      ),
      child: Padding(
        padding: Space.all(15, 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: AppTheme.c.textGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Space.y2!,
            Center(
              child: Text(
                'Report',
                style: AppText.h2bm,
              ),
            ),
            Space.y2!,
            Center(
              child: Text(
                'What\'s the issue?',
                style: AppText.h2b,
              ),
            ),
            Space.y!,
            Center(
              child: Text(
                "Your reports help us keep our community safe. Let us know what's happening.",
                style: AppText.l1,
                textAlign: TextAlign.center,
              ),
            ),
            Space.y2!,
            ..._reportItems
                .map(
                  (e) => TextButton(
                    onPressed: () {
                      ''.pop(context);
                      postsBloc.add(
                        ReportPostEvent(
                          postId: postId,
                          type: e.type,
                          url: imageUrl
                        ),
                      );
                    },
                    child: Text(
                      e.text,
                      style: AppText.b2,
                    ),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
