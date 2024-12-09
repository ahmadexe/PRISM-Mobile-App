part of '../home.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context, listen: true);
    final chainBloc = BlocProvider.of<BlockchainBloc>(context);
    final user = authBloc.state.user!;
    final screenState = _ScreenState.s(context, true);

    return BlocListener<LensBloc, LensState>(
      listener: (context, state) async {
        if (state.analyzeImage is AnalyzePostSuccess) {
          if (user.isSharingData) {
            final data = state.data;
            if (data!.length % 3 == 0) {
              final cache = AppCache();
              final address = await cache.getString('ChainAddress');
              chainBloc.add(
                PostData(
                  data: data,
                  blockchainAddress: address!,
                ),
              );
            }
          }
        }
      },
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: const BottomBar(),
          appBar: AppBar(
            title: const Text('Home'),
            actions: [
              IconButton(
                onPressed: () => AppRoutes.conversations.push(context),
                icon: const Icon(Iconsax.sms_tracking),
              ),
            ],
            scrolledUnderElevation: 0,
          ),
          drawer: const _Drawer(),
          floatingActionButton: GestureDetector(
            onTap: () {
              AppRoutes.chatbot.push(context);
            },
            child: Image.asset(
              AppStaticData.lensIcon,
              height: AppDimensions.normalize(22),
              width: AppDimensions.normalize(22),
            ),
          ),
          body: Padding(
            padding: Space.all(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Avatar(
                        imageUrl: user.imageUrl,
                      ),
                      Space.x1!,
                      Expanded(
                        child: FormBuilder(
                          key: screenState.formKey,
                          child: AppTextField(
                            onTap: () {
                              final form = screenState.formKey.currentState!;
                              form.save();
                              final initialText = form.value[_FormKeys.post];

                              AppRoutes.createPost.push(context,
                                  arguments: {'initialText': initialText});
                            },
                            onChanged: (val) {
                              if (val != null && val.isNotEmpty) {
                                screenState.setPostArrow(true);
                              } else {
                                screenState.setPostArrow(false);
                              }
                            },
                            name: _FormKeys.post,
                            isDarkField: true,
                            type: FieldType.secondary,
                            hint: 'Tell the world a story',
                          ),
                        ),
                      ),
                      if (screenState.showPostArrow) ...[
                        Space.x!,
                        GestureDetector(
                          onTap: () {
                            final form = screenState.formKey.currentState!;
                            form.save();
                            final initialText = form.value[_FormKeys.post];

                            AppRoutes.createPost.push(context,
                                arguments: {'initialText': initialText});
                          },
                          child: const Icon(
                            Iconsax.send_2,
                            color: Colors.white,
                          ),
                        ),
                      ]
                    ],
                  ),
                  Space.y2!,
                  BlocBuilder<PostsBloc, PostsState>(
                    builder: (context, state) {
                      if (state.fetch is PostsfetchLoading ||
                          state.fetch is PostsfetchDefault) {
                        return const PostPlaceHolder();
                      } else if (state.fetch is PostsfetchSuccess) {
                        final posts = state.data!;
                        if (posts.isEmpty) {
                          return Column(
                            children: [
                              Image.asset(
                                AppStaticData.noPostsIcon,
                                height: AppDimensions.normalize(55),
                                width: AppDimensions.normalize(55),
                              ),
                              Space.y1!,
                              Text(
                                'No Posts',
                                style: AppText.h2b,
                              ),
                              Space.y!,
                              Text(
                                'Looks like there are no posts to show.',
                                style: AppText.b2,
                              ),
                            ],
                          );
                        }
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => Post(
                            post: posts[index],
                            index: index,
                          ),
                          separatorBuilder: (context, index) => Space.y1!,
                          itemCount: posts.length,
                        );
                      }
                      return const Center(
                        child: ErrorWarning(
                          title: "Failed to load posts",
                          message:
                              "Looks like there was an error fetching posts.",
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
