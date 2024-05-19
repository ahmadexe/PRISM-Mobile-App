part of '../chat.dart';

class _Body extends StatefulWidget {
  final AuthData receiver;
  const _Body({
    Key? key,
    required this.receiver,
  }) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  void initState() {
    super.initState();
    final sender = BlocProvider.of<AuthBloc>(context).state.user!;
    final chatBloc = BlocProvider.of<ChatsBloc>(context);

    chatBloc.add(
      ConvoInit(
        user1Id: sender.id,
        user2Id: widget.receiver.id,
        user1Name: sender.fullname,
        user2Name: widget.receiver.fullname,
        user1Pic: sender.imageUrl,
        user2Pic: widget.receiver.imageUrl,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context, true);
    final chatBloc = BlocProvider.of<ChatsBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final sender = authBloc.state.user!;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        chatBloc.add(const CloseConvo());
        ''.pop(context);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                if (widget.receiver.imageUrl != null &&
                    widget.receiver.imageUrl!.isNotEmpty) ...[
                  Avatar(
                    imageUrl: widget.receiver.imageUrl!,
                    radius: AppDimensions.normalize(6),
                  ),
                  Space.x1!,
                ],
                Text(widget.receiver.fullname, style: AppText.h3b),
              ],
            ),
            scrolledUnderElevation: 0,
          ),
          body: BlocBuilder<ChatsBloc, ChatsState>(
            builder: (context, state) {
              if (state.convoInit is ConvoInitLoading ||
                  state.socketInit is SocketInitLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final messages = state.messages ?? [];
              return Padding(
                padding: Space.all(),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return _MessageTile(
                              message: messages[index % messages.length]);
                        },
                        separatorBuilder: (context, index) => Space.y2!,
                      ),
                    ),
                    Space.y2!,
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Iconsax.export_1,
                            size: AppDimensions.normalize(7),
                            color: AppTheme.c.textGrey,
                          ),
                        ),
                        Space.x!,
                        Expanded(
                          child: FormBuilder(
                            key: screenState.formKey,
                            child: AppTextField(
                              name: _FormKeys.message,
                              hint: 'Message @${widget.receiver.fullname}',
                              type: FieldType.secondary,
                              isDarkField: true,
                              onChanged: (v) {
                                if (v != null && v.isNotEmpty) {
                                  screenState.setWriting(true);
                                } else {
                                  screenState.setWriting(false);
                                }
                              },
                            ),
                          ),
                        ),
                        Space.x!,
                        GestureDetector(
                          onTap: () {
                            final form = screenState.formKey.currentState!;
                            form.save();
                            final message =
                                form.value[_FormKeys.message] as String;

                            chatBloc.add(
                              SendMessage(
                                message: message,
                                senderId: sender.id,
                                receiverId: widget.receiver.id,
                                createdAt: DateTime.now(),
                                conversationId: state.currentConvo!.id,
                                senderName: sender.fullname,
                                receiverName: widget.receiver.fullname,
                                senderImage: sender.imageUrl,
                                receiverPic: widget.receiver.imageUrl,
                              ),
                            );
                          },
                          child: Icon(
                            Iconsax.send_2,
                            size: AppDimensions.normalize(7),
                            color: screenState.isWriting
                                ? AppTheme.c.primary
                                : AppTheme.c.textGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
