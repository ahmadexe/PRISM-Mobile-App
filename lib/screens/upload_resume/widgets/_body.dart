part of '../upload_resume.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final user = authBloc.state.user!;
    final mediaProvider = MediaProvider.s(context, true);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Hello ${user.fullname}!'),
          scrolledUnderElevation: 0,
          actions: [
            TextButton(
              onPressed: () => AppRoutes.home.pushReplace(context),
              child: Text(
                'Skip',
                style: AppText.b1bm!.cl(AppTheme.c.primary!),
              ),
            )
          ],
        ),
        body: Padding(
          padding: Space.all(),
          child: Column(
            children: [
              const UploadImageBoard(),
              const Spacer(),
              AppButton(
                label: 'Next!',
                onPressed: () {
                  if (mediaProvider.media == null) {
                    SnackBars.failure(
                      context,
                      'Please upload a resume',
                    );
                    return;
                  }
                  AppRoutes.resumeAnalysis.push(context);
                },
                backgroundColor: mediaProvider.media != null
                    ? AppTheme.c.accent
                    : AppTheme.c.fieldLight,
              ),
              Space.y!,
            ],
          ),
        ),
      ),
    );
  }
}
