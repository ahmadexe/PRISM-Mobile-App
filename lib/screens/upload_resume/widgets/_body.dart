part of '../upload_resume.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final user = authBloc.state.user!;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Hello ${user.fullname}!'),
          scrolledUnderElevation: 0,
        ),
        body: const Center(
          child: Text('Upload Resume Screen'),
        ),
      ),
    );
  }
}
