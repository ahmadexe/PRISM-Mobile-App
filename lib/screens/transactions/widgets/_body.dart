part of '../transactions.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Transactions'),
            scrolledUnderElevation: 0,
          ),
          body: const Column(
            children: [_Switcher()],
          )),
    );
  }
}
