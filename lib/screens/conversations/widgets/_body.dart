part of '../conversations.dart';

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  void initState() {
    super.initState();
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final user = authBloc.state.user!;
    final chatBloc = BlocProvider.of<ChatsBloc>(context);
    chatBloc.add(FetchAllConvos(id: user.id));
  }

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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            BlocBuilder<ChatsBloc, ChatsState>(
              builder: (context, state) {
                if (state.fetchAllConvos is FetchAllConvosLoading ||
                    state.fetchAllConvos is FetchAllConvosDefault) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.fetchAllConvos is FetchAllConvosSuccess) {
                  final convos = state.convos;
                  if (convos == null || convos.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Space.yf(30),
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
                    );
                  } else {
                    return ListView.separated(
                      itemCount: convos.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final convo = convos[index];
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
                    );
                  }
                } else {
                  return const ErrorWarning(
                    title: 'Hmmmmmmm..',
                    message:
                        'Looks like there was a problem fetching conversations.',
                  );
                }
                // return const SizedBox.shrink();
              },
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
          ]),
        ),
      ),
    );
  }
}
