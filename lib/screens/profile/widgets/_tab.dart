part of '../profile.dart';

class _Tab extends StatelessWidget {
  final DateTime memberSince;
  const _Tab({required this.memberSince});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.normalize(35),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.c.fieldDark,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: Space.hf(10),
        child: Padding(
          padding: Space.all(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Member since',
                style: AppText.h3bm,
              ),
              Space.y!,
              Text(
                DateFormat.yMMMMd().format(memberSince),
                style: AppText.b2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
