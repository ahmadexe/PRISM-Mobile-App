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
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          AppStaticData.logoSvg,
          height: AppDimensions.normalize(55),
          width: AppDimensions.normalize(55),
        ),
      ),
    );
  }
}
