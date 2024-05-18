part of '../profile.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context, listen: true);
    final user = authBloc.state.user!;
    final postsBloc = BlocProvider.of<PostsBloc>(context);
    final usersPost =
        postsBloc.state.data!.where((post) => post.userId == user.id).toList();

    return SafeArea(
      top: false,
      left: false,
      right: false,
      child: Scaffold(
        bottomNavigationBar: const BottomBar(),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.logout is AuthLogoutSuccess) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.login,
                (route) => false,
              );
            }
          },
          child: SingleChildScrollView(
            child: Column(
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
                          )
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
          ),
        ),
      ),
    );
  }
}
