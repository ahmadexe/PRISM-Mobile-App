part of '../forgot_password.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context, true);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Forgot Password'),
          actions: [
            SvgPicture.asset(
              AppStaticData.logoSvg,
              height: AppDimensions.normalize(20),
              width: AppDimensions.normalize(20),
            ),
          ],
        ),
        body: Column(
          children: [],
        ),
      ),
    );
  }
}
