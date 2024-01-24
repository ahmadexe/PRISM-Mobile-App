part of '../shout_outs.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Shout Outs'),
        ),
        body: const Center(
          child: Text('Shout Outs'),
        ),
      ),
    );
  }
}
