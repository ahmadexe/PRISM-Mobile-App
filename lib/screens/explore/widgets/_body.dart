part of '../explore.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const BottomBar(),
        appBar: AppBar(
          title: const Text('Explore'),
          scrolledUnderElevation: 0,
        ),
        body: const Center(
          child: Text('Explore'),
        ),
      ),
    );
  }
}
