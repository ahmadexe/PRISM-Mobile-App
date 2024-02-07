part of '../splash.dart';

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state.init is AuthInitSuccess) {
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        } else if (state.init is AuthInitFailure) {
          await Future.delayed(const Duration(seconds: 2));
          if (!mounted) return;
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
