part of '../profile.dart';

class _InfoTile extends StatelessWidget {
  final String domain;
  final bool isEdit;
  const _InfoTile({this.isEdit = false, this.domain = ''});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isEdit) {
          AppRoutes.editProfile.push(context);
        }
      },
      child: Container(
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
                isEdit ? Iconsax.path : getIcon(domain),
                size: 20,
                color: AppTheme.c.accent,
              ),
              Space.x!,
              Text(
                isEdit ? 'Edit' : domain,
                style: AppText.l1bm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
