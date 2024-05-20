part of '../chatbot.dart';

class _MessageBubble extends StatelessWidget {
  final LensMessage message;
  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    if (message.isFromLens) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            AppStaticData.lensIcon,
            height: AppDimensions.normalize(14),
            width: AppDimensions.normalize(14),
          ),
          Space.x1!,
          Expanded(child: Text(message.message)),
        ],
      );
    }
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: Space.all(AppDimensions.normalize(4)),
        decoration: BoxDecoration(
          color: AppTheme.c.primary!,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          message.message,
        ),
      ),
    );
  }
}
