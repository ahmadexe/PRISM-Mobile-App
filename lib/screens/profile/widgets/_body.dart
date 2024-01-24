part of '../profile.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const BottomBar(),
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: const Center(
          child: Text('Profile'),
        ),
      ),
    );
  }
}
