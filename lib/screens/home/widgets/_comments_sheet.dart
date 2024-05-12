part of '../home.dart';

class _CommentsSheet extends StatefulWidget {
  final Post post;
  final _ScreenState screenState;
  const _CommentsSheet({required this.post, required this.screenState});

  @override
  State<_CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends State<_CommentsSheet> {
  @override
  void initState() {
    super.initState();
    final commentsBloc = BlocProvider.of<CommentsBloc>(context);
    commentsBloc.add(FetchCommentsEvent(postId: widget.post.id));
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    final commentBloc = BlocProvider.of<CommentsBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final user = authBloc.state.user!;

    return Container(
      height: media.height * .95,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.c.backgroundSub,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            AppDimensions.normalize(10),
          ),
        ),
      ),
      child: Padding(
        padding: Space.all(),
        child: Column(
          children: [
            Container(
              width: media.width * .1,
              height: AppDimensions.normalize(3),
              decoration: BoxDecoration(
                color: AppTheme.c.grey,
                borderRadius: BorderRadius.circular(
                  AppDimensions.normalize(5),
                ),
              ),
            ),
            Space.y!,
            Text(
              'Comments',
              style: AppText.b1bm,
            ),
            BlocBuilder<CommentsBloc, CommentsState>(
              builder: (context, state) {
                if (state.fetch is FetchCommentsLoading ||
                    state.fetch is FetchCommentsDefault) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.fetch is FetchCommentsSuccess) {
                  final data = state.data!;
                  if (data.isEmpty) {
                    return Expanded(
                      child: Padding(
                        padding: Space.vf(100),
                        child: Column(
                          children: [
                            Icon(
                              Iconsax.search_zoom_out,
                              size: AppDimensions.normalize(30),
                              color: AppTheme.c.textGrey,
                            ),
                            Space.y!,
                            Text(
                              'No posts yet',
                              style: AppText.h3b!.cl(AppTheme.c.textGrey!),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final comment = data[index];
                        return Padding(
                          padding: Space.v!,
                          child: ListTile(
                            leading: Avatar(
                              imageUrl: comment.userProfilePic,
                            ),
                            title: Text(comment.userName),
                            subtitle: Text(comment.content),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: ErrorWarning(
                      title: 'Failed to load comments',
                      message:
                          'Looks like there was an error fetching comments.',
                    ),
                  );
                }
              },
            ),
            Padding(
              padding: Space.v!,
              child: Row(
                children: [
                  Expanded(
                    child: FormBuilder(
                      key: widget.screenState.commentFormKey,
                      child: AppTextField(
                        hint: 'Add a comment',
                        name: _FormKeys.comment,
                        type: FieldType.secondary,
                        validator: FormBuilderValidators.required(),
                      ),
                    ),
                  ),
                  Space.x1!,
                  GestureDetector(
                    onTap: () {
                      final form = widget.screenState.commentFormKey.currentState!;
                      if (!form.saveAndValidate()) return;
                      final content = form.value[_FormKeys.comment] as String;

                      commentBloc.add(
                        CreateCommentEvent(
                          postId: widget.post.id,
                          userId: user.id,
                          content: content,
                          userName: user.fullname,
                          userProfilePic: user.imageUrl,
                          createdAt: DateTime.now(),
                        ),
                      );
                    },
                    child: Icon(
                      Iconsax.send_2,
                      size: AppDimensions.normalize(10),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
