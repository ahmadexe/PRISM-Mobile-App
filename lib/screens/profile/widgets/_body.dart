part of '../profile.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final user = authBloc.state.user!;
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
                        : Image.network(
                            user.bannerImageUrl!,
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
                              backgroundImage: NetworkImage(user.imageUrl!),
                            ),
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
                            const _InfoTile(
                              isEdit: true,
                            ),
                            Space.x!,
                            _InfoTile(
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
              Space.yf(70),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
            ],
          ),
        ),
      ),
    );
  }
}
