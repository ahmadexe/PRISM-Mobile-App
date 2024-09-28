part of 'post.dart';

class _ReportModal extends StatelessWidget {
  final String postId;
  final String imageUrl;
  const _ReportModal({
    required this.postId,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);

    return Container(
      width: double.infinity,
      height: media.height * .3,
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
                'Issues?',
                style: AppText.h2b,
              ),
            ),
            Center(
              child: Text(
                "PRISM is committed to keeping our community safe. Let us know if you see anything that doesn't belong.",
                style: AppText.l1,
              ),
            ),
            Space.ym!,
            Center(
              child: AppButton(
                onPressed: () {
                  ''.pop(context);
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => _TypeModal(
                      postId: postId,
                      imageUrl: imageUrl,
                    ),
                  );
                },
                label: 'Report Post',
              ),
            ),
            Space.y2!,
            AppButton(
              backgroundColor: AppTheme.c.accent,
              onPressed: () {},
              label: 'Report User',
            ),
            Space.y2!,
          ],
        ),
      ),
    );
  }
}
