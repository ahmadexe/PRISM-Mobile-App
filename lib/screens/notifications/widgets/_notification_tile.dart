part of '../notifications.dart';

class _NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  const _NotificationTile({required this.notification, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: Space.all(),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: AppTheme.c.fieldLight!.withValues(alpha: .75),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(notification.title, style: AppText.b1bm),
          Space.y!,
          Text(notification.body, style: AppText.b1),
        ],
      ),
    );
  }
}
