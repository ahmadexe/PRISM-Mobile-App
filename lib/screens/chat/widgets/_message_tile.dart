part of '../chat.dart';

class _MessageTile extends StatelessWidget {
  final Message message;
  const _MessageTile({required this.message});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final isMe = authBloc.state.user!.id == message.senderId;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Avatar(
          imageUrl: message.senderPic,
        ),
        Space.x1!,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  message.senderName,
                  style: AppText.b1b!.cl(
                    isMe ? AppTheme.c.primary! : AppTheme.c.accent!,
                  ),
                ),
                Space.x1!,
                Text(
                  DateFormat('dd/MM/yyyy hh:mm a').format(message.createdAt),
                  style: AppText.l1!.cl(Colors.grey),
                ),
              ],
            ),
            Space.y!,
            SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              child: Text(
                message.message,
                style: AppText.b2bm!,
                maxLines: null,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
