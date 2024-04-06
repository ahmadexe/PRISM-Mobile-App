part of '../profile.dart';

class _DomainTab extends StatelessWidget {
  final String domain;
  const _DomainTab({required this.domain});

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
              getIcon(domain),
              size: 20,
              color: AppTheme.c.accent,
            ),
            Space.x!,
            Text(
              domain,
              style: AppText.l1bm,
            ),
          ],
        ),
      ),
    );
  }
}
