part of '../wallet.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Wallet'),
          scrolledUnderElevation: 0,
        ),
        body: Padding(
          padding: Space.all(),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BalanceCard(
                balance: 1000,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
