part of '../wallet.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context, true);
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
              Text(
                'Transactions',
                style: AppText.h3b,
              ),
              Space.y!,
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    screenState.toggleMainData();
                  },
                ),
              ),
              _LineChart(isShowingMainData: screenState.isShowingMainData),
            ],
          ),
        ),
      ),
    );
  }
}
