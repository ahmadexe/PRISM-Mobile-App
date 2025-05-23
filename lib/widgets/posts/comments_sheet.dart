import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:iconsax/iconsax.dart';
import 'package:prism/blocs/auth/bloc.dart';
import 'package:prism/blocs/comments/bloc.dart';
import 'package:prism/configs/configs.dart';
import 'package:prism/models/post/post.dart';
import 'package:prism/widgets/avatar.dart';
import 'package:prism/widgets/core/error/error.dart';
import 'package:prism/widgets/design/input/app_text_field.dart';
import 'package:prism/widgets/posts/posts_placeholder.dart';

class CommentsSheet extends StatefulWidget {
  final PostData post;
  const CommentsSheet({super.key, required this.post});

  @override
  State<CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends State<CommentsSheet> {
  @override
  void initState() {
    super.initState();
    final commentsBloc = BlocProvider.of<CommentsBloc>(context);
    commentsBloc.add(FetchCommentsEvent(postId: widget.post.id));
  }

  static final _formKey = GlobalKey<FormBuilderState>();
  int comments = 0;

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
            Row(
              children: [
                GestureDetector(
                    onTap: () => ''.pop(context, comments),
                    child: const Icon(Icons.keyboard_arrow_down_rounded)),
                Padding(
                  padding: Space.hf(155),
                  child: Container(
                    width: media.width * .1,
                    height: AppDimensions.normalize(3),
                    decoration: BoxDecoration(
                      color: AppTheme.c.grey,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.normalize(5),
                      ),
                    ),
                  ),
                ),
              ],
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
                  return const Expanded(
                    child: PostPlaceHolder(),
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
                              'No comments yet',
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
                      key: _formKey,
                      child: AppTextField(
                        hint: 'Add a comment',
                        name: 'comment',
                        type: FieldType.secondary,
                        validator: FormBuilderValidators.required(),
                      ),
                    ),
                  ),
                  Space.x1!,
                  BlocConsumer<CommentsBloc, CommentsState>(
                    listenWhen: CreateCommentState.match,
                    listener: (context, state) {
                      if (state.create is CreateCommentSuccess) {
                        comments++;
                      }
                    },
                    builder: (context, state) {
                      if (state.create is CreateCommentLoading) {
                        return Icon(
                          Iconsax.send_2,
                          size: AppDimensions.normalize(10),
                          color: Colors.grey,
                        );
                      }
                      return GestureDetector(
                        onTap: () {
                          final form = _formKey.currentState!;
                          if (!form.saveAndValidate()) return;
                          final content = form.value['comment'] as String;

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

                          form.reset();
                        },
                        child: Icon(
                          Iconsax.send_2,
                          size: AppDimensions.normalize(10),
                        ),
                      );
                    },
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
