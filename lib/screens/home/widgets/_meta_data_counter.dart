part of '../home.dart';

class _MetaDataCounter extends StatelessWidget {
  final Post post;
  const _MetaDataCounter({required this.post});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(.5)),
            borderRadius: BorderRadius.circular(100),
          ),
          padding: Space.all(4, 4),
          child: Row(
            children: [
              Icon(
                Iconsax.arrow_up,
                color: AppTheme.c.primary,
              ),
              Space.x!,
              Text(
                post.upVotes.toString(),
                style: AppText.b2,
              ),
              Space.x1!,
              Text('|', style: AppText.b2!.cl(Colors.grey)),
              Space.x!,
              Icon(
                Iconsax.arrow_bottom,
                color: AppTheme.c.accent,
              ),
            ],
          ),
        ),
        Space.x2!,
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(.5)),
            borderRadius: BorderRadius.circular(100),
          ),
          padding: Space.all(10, 6),
          child: Row(
            children: [
              const Icon(
                Iconsax.messages,
                color: Colors.white,
                size: 20,
              ),
              Space.x!,
              Text(
                '${post.noOfComments} Comments',
                style: AppText.b2bm,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
