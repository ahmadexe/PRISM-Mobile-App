part of '../profile.dart';

class _Body extends StatefulWidget {
  final String? userId;
  final bool? isApplicant;
  const _Body({this.userId, this.isApplicant});

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  void initState() {
    if (widget.userId != null) {
      BlocProvider.of<AuthBloc>(context)
          .add(GetUserByIdEvent(id: widget.userId!));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isMe = widget.userId == null;

    return SafeArea(
      top: false,
      left: false,
      right: false,
      child: Scaffold(
        bottomNavigationBar: const BottomBar(),
        body: BlocConsumer<AuthBloc, AuthState>(
          listenWhen: AuthLogoutState.match,
          listener: (context, state) {
            if (state.logout is AuthLogoutSuccess) {
              final cache = AppCache();
              cache.clear();
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.login,
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            if (state.get is GetUserLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.get is GetUserSuccess && !isMe) {
              final user = state.get.user!;

              return _Profile(
                  user: user, isMe: isMe, isApplicant: widget.isApplicant);
            } else if (state.get is GetUserFailure) {
              return const Center(
                child: ErrorWarning(
                  title: "Failed to load posts",
                  message: "Looks like there was an error fetching posts.",
                ),
              );
            } else {
              final user = state.user!;
              return _Profile(user: user);
            }
          },
        ),
      ),
    );
  }
}
