part of '../chatbot.dart';

class _MessageBubble extends StatelessWidget {
  final AgentMessage message;
  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    if (message.isFromAgent) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            AppStaticData.lensIcon,
            height: AppDimensions.normalize(15),
            width: AppDimensions.normalize(15),
          ),
          Space.x!,
          Expanded(child: Text(message.content)),
        ],
      );
    }
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        children: [
          Container(
            padding: Space.all(AppDimensions.normalize(4)),
            decoration: BoxDecoration(
              color: AppTheme.c.primary!,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              message.content,
            ),
          ),
          if (message.imageData != null) ...[
            Space.y!,
            Align(
              alignment: Alignment.centerRight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.memory(
                  width: AppDimensions.normalize(45),
                  height: AppDimensions.normalize(45),
                  message.imageData!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Space.y1!,
          ] else if (message.imageUrl != null &&
              message.imageUrl!.isNotEmpty) ...[
            Space.y!,
            Align(
              alignment: Alignment.centerRight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  width: AppDimensions.normalize(45),
                  height: AppDimensions.normalize(45),
                  message.imageUrl!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Space.y1!,
          ],
        ],
      ),
    );
  }
}
