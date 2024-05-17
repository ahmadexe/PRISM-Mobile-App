part of '../conversations.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final currentUser = authBloc.state.user!;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Conversations'),
          scrolledUnderElevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          shape: const CircleBorder(),
          child: const Icon(Iconsax.messages_3),
        ),
        body: Padding(
          padding: Space.all(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                name: _FormKeys.search,
                hint: 'Search...',
                suffixIcon: Icon(
                  Iconsax.search_status,
                  size: AppDimensions.normalize(7),
                ),
                type: FieldType.secondary,
              ),
              Space.yf(30),
              if (conversations.isEmpty)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppStaticData.noMessages,
                          height: AppDimensions.normalize(60),
                          width: AppDimensions.normalize(60),
                        ),
                        Space.y2!,
                        Text(
                          'No messages yet',
                          style: AppText.h2bm,
                        ),
                        Space.y!,
                        Text(
                          'Start a conversation with your friends',
                          style: AppText.b2b!.cl(AppTheme.c.textGrey!),
                        ),
                        Space.yf(AppDimensions.normalize(100))
                      ],
                    ),
                  ),
                )
              else ...[
                ListView.separated(
                  itemCount: conversations.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final convo = conversations[index];
                    final otherUser =
                        isCurrentUser(currentUser.id, convo.user1Id)
                            ? {
                                'id': convo.user2Id,
                                'name': convo.user2Name,
                                'pic': convo.user2Pic
                              }
                            : {
                                'id': convo.user1Id,
                                'name': convo.user1Name,
                                'pic': convo.user1Pic
                              };
                    return ListTile(
                      leading: Avatar(
                        imageUrl: otherUser['pic'],
                      ),
                      title: Text(otherUser['name'] as String),
                      onTap: () => AppRoutes.chat.push(context, arguments: {
                        'receiverId': otherUser['id'],
                        'receiverName': otherUser['name'],
                        'receiverPic': otherUser['pic'],
                      }),
                    );
                  },
                  separatorBuilder: (context, index) => Space.y2!,
                ),
                Space.yf(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Invite more friends >',
                      style: AppText.b2b!.cl(AppTheme.c.textGrey!),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Iconsax.directbox_send,
                            size: AppDimensions.normalize(6),
                            color: AppTheme.c.textGrey,
                          ),
                        ),
                        Space.x1!,
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Iconsax.scan,
                            size: AppDimensions.normalize(6),
                            color: AppTheme.c.textGrey,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
