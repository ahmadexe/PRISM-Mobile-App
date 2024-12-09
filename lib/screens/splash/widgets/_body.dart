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

    BlocProvider.of<BlockchainBloc>(context).add(
      GetConnectionString(),
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
    final chainBloc = BlocProvider.of<BlockchainBloc>(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
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

              notificationsBloc.add(
                FetchNotifications(uid: user.uid),
              );

              final cache = AppCache();
              final publicKey = await cache.getString("PublicKey");
              final privateKey = await cache.getString("PrivateKey");
              if (publicKey != null && privateKey != null) {
                walletBloc.add(GetWalletDetails(
                  nodeAddress: chainBloc.state.address!,
                  publicKey: publicKey,
                  privateKey: privateKey,
                ));
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                }
              } else {
                if (context.mounted) {
                  Navigator.pushReplacementNamed(
                      context, AppRoutes.generateWallet);
                }
              }
            } else if (state.init is AuthInitFailure) {
              await Future.delayed(const Duration(seconds: 2));
              if (!context.mounted) return;
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            }
          },
        ),
        BlocListener<BlockchainBloc, ChainState>(
          listenWhen: (a, b) => NodeState.match(a, b),
          listener: (context, state) async {
            if (state.node is NodeSuccess) {
              final address = state.address!;
              chainBloc.add(
                GetData(
                  nodeAddress: address,
                ),
              );
              // walletBloc.add(GetWalletDetails(
              //   nodeAddress: address,
              //   publicKey: publicKey,
              //   privateKey: privateKey,
              // ));
            }
          },
        ),
      ],
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
