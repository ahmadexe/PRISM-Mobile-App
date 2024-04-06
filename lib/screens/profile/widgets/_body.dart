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
                    Image.asset(
                      AppStaticData.bannerDef,
                      height: AppDimensions.normalize(65),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      left: 16,
                      right: 16,
                      top: 105,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: AppDimensions.normalize(17),
                            backgroundImage: const AssetImage(
                              AppStaticData.dpDef,
                            ),
                          ),
                        ],
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
                        const _DomainTab()
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
                        Column(
                          children: [
                            const Icon(Iconsax.ranking, size: 30),
                            Text('Ranked', style: AppText.b2),
                          ],
                        ),
                        Column(
                          children: [
                            Text('273', style: AppText.h2b),
                            Text('Followers', style: AppText.b2),
                          ],
                        ),
                        Column(
                          children: [
                            Text('1,116', style: AppText.h2b),
                            Text('Following', style: AppText.b2),
                          ],
                        ),
                      ],
                    ),
                    Space.y2!,
                    _Tab(memberSince: DateTime.now())
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
