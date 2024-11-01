part of '../wallet.dart';

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  initState() {
    super.initState();
    BlocProvider.of<WalletBloc>(context).add(const GetWalletDetails());
  }

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
          child: Stack(
            children: [
              BlocBuilder<WalletBloc, WalletState>(
                builder: (context, state) {
                  if (state.walletInfo is WalletInfoLoading ||
                      state.walletInfo is WalletInfoDefault) {
                    return const FullScreenLoader();
                  } else if (state.walletInfo is WalletInfoError) {
                    return const Center(
                      child: ErrorWarning(
                          title: 'Hmmm',
                          message: 'An error occured, we are working on it'),
                    );
                  }
                  final wallet = state.wallet!;
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _BalanceCard(
                          balance: wallet.amount,
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
                        _LineChart(
                            isShowingMainData: screenState.isShowingMainData),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
