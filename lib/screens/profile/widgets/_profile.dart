part of '../profile.dart';

class _Profile extends StatelessWidget {
  final AuthData user;
  final bool isMe;
  final bool? isApplicant;
  const _Profile({required this.user, this.isMe = true, this.isApplicant});

  @override
  Widget build(BuildContext context) {
    final postsBloc = BlocProvider.of<PostsBloc>(context);
    final usersPost =
        postsBloc.state.data!.where((post) => post.userId == user.id).toList();

    final authBloc = BlocProvider.of<AuthBloc>(context);
    final currentUser = authBloc.state.user!;
    final screenState = _ScreenState.s(context);
    final notisBloc = BlocProvider.of<NotificationsBloc>(context);
    final jobsBloc = BlocProvider.of<JobsBloc>(context);
    final jobProvider = Provider.of<JobProvider>(context, listen: false);

    final notisBloc 

    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: AppDimensions.normalize(75),
                child: Stack(
                  children: [
                    user.bannerImageUrl == null
                        ? Image.asset(
                            AppStaticData.bannerDef,
                            height: AppDimensions.normalize(65),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            imageUrl: user.bannerImageUrl!,
                            height: AppDimensions.normalize(65),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                    user.imageUrl != null
                        ? Positioned(
                            left: 16,
                            top: 105,
                            child: CircleAvatar(
                                radius: AppDimensions.normalize(17),
                                backgroundImage: CachedNetworkImageProvider(
                                  user.imageUrl!,
                                )),
                          )
                        : Positioned(
                            left: 16,
                            top: 105,
                            child: CircleAvatar(
                              radius: AppDimensions.normalize(17),
                              backgroundImage: const AssetImage(
                                AppStaticData.dpDef,
                              ),
                            ),
                          ),
                    if (isMe)
                      Positioned(
                        right: AppDimensions.normalize(7),
                        top: AppDimensions.normalize(15),
                        child: GestureDetector(
                          onTap: () {
                            AppRoutes.settings.push(context);
                          },
                          child: Container(
                            padding: Space.all(),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Icon(
                              Iconsax.setting_2,
                              size: AppDimensions.normalize(8),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: Space.all(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(user.fullname, style: AppText.h3b),
                        if (isMe)
                          Row(
                            children: [
                              const InfoTile(
                                isEdit: true,
                              ),
                              Space.x!,
                              InfoTile(
                                domain: user.domain,
                              ),
                            ],
                          ),
                        if (!isMe)
                          InfoTile(
                            domain: user.domain,
                          ),
                        if ((isApplicant != null && isApplicant!) &&
                            jobProvider.selectedJob!.hired == null)
                          AppButton(
                            label: 'Hire?',
                            width: AppDimensions.normalize(30),
                            height: 35,
                            buttonType: ButtonType.secondary,
                            onPressed: () {
                              jobsBloc.add(
                                HireApplicant(
                                  jobId: jobProvider.selectedJob!.id,
                                  userId: user.id,
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                    Space.y!,
                    Text(
                      user.bio,
                      style: AppText.b2,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Space.y2!,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (user.isRanked)
                          Column(
                            children: [
                              const Icon(Iconsax.ranking, size: 30),
                              Text('Ranked', style: AppText.b2),
                            ],
                          ),
                        Column(
                          children: [
                            Text(user.followers.length.toString(),
                                style: AppText.h2b),
                            Text('Followers', style: AppText.b2),
                          ],
                        ),
                        Column(
                          children: [
                            Text(user.following.length.toString(),
                                style: AppText.h2b),
                            Text('Following', style: AppText.b2),
                          ],
                        ),
                      ],
                    ),
                    if (!isMe) ...[
                      Space.y2!,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AppButton(
                            label: 'Message',
                            onPressed: () =>
                                AppRoutes.chat.push(context, arguments: {
                              'receiverId': user.id,
                              'receiverName': user.fullname,
                              'receiverPic': user.imageUrl,
                            }),
                            width: AppDimensions.normalize(67),
                            height: AppDimensions.normalize(15),
                            buttonType: ButtonType.secondary,
                            backgroundColor: AppTheme.c.grey,
                          ),
                          AppButton(
                            label: user.followers.contains(currentUser.id)
                                ? 'Unfollow'
                                : 'Follow',
                            onPressed: () {
                              authBloc.add(ToggleFollowEvent(
                                  to: user.id, from: currentUser.id));

                              if (!user.followers.contains(currentUser.id)) {
                                notisBloc.add(SendNotification(
                                  title: 'New Follower',
                                  body:
                                      '${currentUser.fullname} started following you',
                                  uid: user.uid,
                                  deviceToken: user.deviceToken,
                                  type: 'follow',
                                ));
                              }
                              screenState.toggleFollow();
                            },
                            width: AppDimensions.normalize(67),
                            height: AppDimensions.normalize(15),
                            buttonType: ButtonType.secondary,
                            backgroundColor:
                                user.followers.contains(currentUser.id)
                                    ? AppTheme.c.grey
                                    : AppTheme.c.primary,
                          ),
                        ],
                      )
                    ],
                    Space.y2!,
                    _Tab(memberSince: user.createdAt)
                  ],
                ),
              ),
              if (usersPost.isNotEmpty) ...[
                Space.y2!,
                ListView.separated(
                  shrinkWrap: true,
                  padding: Space.all(),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>
                      _PostMetaCard(post: usersPost[index]),
                  separatorBuilder: (context, index) => Space.y1!,
                  itemCount: usersPost.length,
                ),
              ] else ...[
                Space.yf(70),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppStaticData.noPostsIcon,
                        height: AppDimensions.normalize(70),
                        width: AppDimensions.normalize(70),
                      ),
                      Space.y!,
                      Text(
                        'No posts yet',
                        style: AppText.h3b!.cl(AppTheme.c.textGrey!),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          BlocConsumer<JobsBloc, JobsState>(
            listener: (context, state) {
              if (state.apply is ApplyForJobSuccess) {
                SnackBars.success(context, 'This user has been hired!');
              } else if (state.apply is ApplyForJobFailure) {
                SnackBars.failure(context, 'Failed to hire the user');
              }
            },
            builder: (context, state) {
              if (state.hire is HireApplicantLoading) {
                return const FullScreenLoader();
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}
