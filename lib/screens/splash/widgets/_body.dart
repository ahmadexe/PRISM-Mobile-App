part of '../splash.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          'assets/logo/prism_logo.svg',
          height: AppDimensions.normalize(55),
          width: AppDimensions.normalize(55),
        ),
      ),
    );
  }
}
