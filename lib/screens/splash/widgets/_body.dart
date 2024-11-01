part of '../splash.dart';

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  void initState() {
    final postsProvider = BlocProvider.of<PostsBloc>(context);
    postsProvider.add(
      const PostsFetchEvent(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final jobsBloc = BlocProvider.of<JobsBloc>(context);
    final notificationsBloc = BlocProvider.of<NotificationsBloc>(context);
    final walletBloc = BlocProvider.of<WalletBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listenWhen: AuthInitState.match,
      listener: (context, state) async {
        if (state.init is AuthInitSuccess) {
          final user = state.user!;

          authBloc.add(UpdateDeviceToken(userId: user.id));

          if (user.isBusinessAcc) {
            jobsBloc.add(
              FetchMyJobs(userId: user.id),
            );
            jobsBloc.add(
              const FetchJobs(),
            );
          } else if (user.isServiceProvider) {
            jobsBloc.add(
              const FetchJobs(),
            );
            jobsBloc.add(
              FetchApplications(id: user.id, isUser: true),
            );
          }

          walletBloc.add(
            const GetWalletDetails()
          );

          notificationsBloc.add(
            FetchNotifications(uid: user.uid),
          );

          Navigator.pushReplacementNamed(context, AppRoutes.home);
        } else if (state.init is AuthInitFailure) {
          await Future.delayed(const Duration(seconds: 2));
          if (!context.mounted) return;
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        }
      },
      child: Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SvgPicture.asset(
                  AppStaticData.logoSvg,
                  height: AppDimensions.normalize(55),
                  width: AppDimensions.normalize(55),
                ),
              );
            } else {
              authBloc.add(
                AuthInit(
                  user: snapshot.data,
                ),
              );
            }
            return Center(
              child: SvgPicture.asset(
                AppStaticData.logoSvg,
                height: AppDimensions.normalize(55),
                width: AppDimensions.normalize(55),
              ),
            );
          },
        ),
      ),
    );
  }
}
