part of '../create_post.dart';

class _Body extends StatelessWidget {
  final String? initialText;
  const _Body({required this.initialText});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final postsBloc = BlocProvider.of<PostsBloc>(context);
    final mediaProvider = MediaProvider.s(context, true);
    final screenState = _ScreenState.s(context, true);
    final user = authBloc.state.user!;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Post'),
          scrolledUnderElevation: 0,
        ),
        body: Stack(
          children: [
            Padding(
              padding: Space.all(),
              child: SingleChildScrollView(
                child: FormBuilder(
                  key: screenState.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Avatar(
                        imageUrl: authBloc.state.user!.imageUrl,
                        radius: AppDimensions.normalize(9),
                      ),
                      Space.yf(30),
                      AppTextField(
                        name: _FormKeys.title,
                        hint: 'Title',
                        isDarkField: true,
                        validator: FormBuilderValidators.required(),
                      ),
                      Space.y!,
                      AppTextField(
                        initialValue: initialText,
                        name: _FormKeys.description,
                        hint: 'Tell your story...',
                        maxLines: 100,
                        minLines: 4,
                        isDarkField: true,
                      ),
                      const UploadImageBoard(),
                      Space.yf(50),
                      AppButton(
                          label: 'Post',
                          onPressed: () {
                            final form = screenState.formKey.currentState!;
                            final isValid = form.saveAndValidate();
                            if (!isValid) return;

                            final media = mediaProvider.media;
                            final description =
                                form.value[_FormKeys.description] as String?;

                            if (media == null && description == null) {
                              SnackBars.failure(
                                  context, 'Please add media or description.');
                              return;
                            }

                            final title = form.value[_FormKeys.title] as String;
                            final userId = user.id;
                            final category = user.domain;
                            final userName = user.fullname;
                            final userProfilePic = user.imageUrl;

                            final Map<String, dynamic> payload = {
                              'title': title,
                              'description': description,
                              'userId': userId,
                              'category': category,
                              'userName': userName,
                              'userProfilePic': userProfilePic,
                            };

                            postsBloc.add(
                              PostCreateEvent(
                                payload: payload,
                                image: media,
                              ),
                            );
                          })
                    ],
                  ),
                ),
              ),
            ),
            BlocConsumer<PostsBloc, PostsState>(
              listener: (context, state) {
                if (state.post is CreatePostSuccess) { 
                  SnackBars.success(context, 'Post created successfully');
                  ''.pop(context);
                } else if (state.post is CreatePostFailure) {
                  SnackBars.failure(context, 'Failed to create post');
                }
              },
              builder: (context, state) {
                if (state.post is CreatePostLoading) {
                  return const FullScreenLoader();
                }
                return const SizedBox.shrink();
              },
            )
          ],
        ),
      ),
    );
  }
}
