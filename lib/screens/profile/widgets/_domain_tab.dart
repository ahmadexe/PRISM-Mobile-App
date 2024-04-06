part of '../profile.dart';

class _DomainTab extends StatelessWidget {
  const _DomainTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        color: AppTheme.c.fieldLight!.withOpacity(.75),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: Space.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Iconsax.code_circle,
              size: 20,
              color: AppTheme.c.accent,
            ),
            Space.x!,
            Text(
              'Software',
              style: AppText.l1bm,
            ),
          ],
        ),
      ),
    );
  }
}
