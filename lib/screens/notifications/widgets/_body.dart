part of '../notifications.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const BottomBar(),
        appBar: AppBar(
          title: const Text('Notifications'),
        ),
        body: const Center(
          child: Text('Notifications'),
        ),
      ),
    );
  }
}
