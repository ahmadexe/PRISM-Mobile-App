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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _BalanceCard(
                balance: 1000,
              ),
              Space.y2!,
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ActionsCard(
                    isTransaction: true,
                  ),
                  _ActionsCard(
                    isTransaction: false,
                  ),
                ],
              ),
              Space.yf(70),
              const _LineChart(isShowingMainData: true),
            ],
          ),
        ),
      ),
    );
  }
}
