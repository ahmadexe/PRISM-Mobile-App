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
                    return ListTile(
                      leading: Avatar(
                        imageUrl: isCurrentUser(currentUser.id, convo.user1Id)
                            ? convo.user2Pic
                            : convo.user1Pic,
                      ),
                      title: isCurrentUser(currentUser.id, convo.user1Id)
                          ? Text(convo.user2Name)
                          : Text(convo.user1Name),
                      onTap: () {},
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
