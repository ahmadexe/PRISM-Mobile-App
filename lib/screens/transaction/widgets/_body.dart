part of '../transaction.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context, true);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(''),
          scrolledUnderElevation: 0,
        ),
        body: const Center(
          child: Text(''),
        ),
      ),
    );
  }
}
