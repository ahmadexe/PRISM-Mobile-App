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
        ),
        body: Padding(
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
                  if (mediaProvider.media != null) ...[
                    Space.y2!,
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(mediaProvider.media!.path),
                            height: AppDimensions.normalize(150),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: AppDimensions.normalize(150),
                          width: double.infinity,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          left: 0,
                          bottom: 0,
                          child: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => const PickImageModal(),
                              );
                            },
                            icon: const Icon(
                              Iconsax.image,
                              size: 50,
                            ),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    Space.yf(80),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => const PickImageModal(),
                        );
                      },
                      child: Center(
                        child: Image.asset(
                          AppStaticData.noMediaIcon,
                          height: AppDimensions.normalize(60),
                          width: AppDimensions.normalize(60),
                        ),
                      ),
                    ),
                    Space.y!,
                    Center(
                      child: Text(
                        'Add media',
                        style: AppText.h1bm,
                      ),
                    ),
                  ],
                  // const Spacer(),
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
      ),
    );
  }
}
