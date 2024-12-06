part of '../wallet.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context, true);
    final transactionBloc = BlocProvider.of<TransactionBloc>(context);
    final nodeBloc = BlocProvider.of<NodeBloc>(context);
    final nodeAddress = nodeBloc.state.address!;
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
                        Row(
                          children: [
                            Text(
                              'Transactions',
                              style: AppText.h3b,
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                AppRoutes.transactions.push(context);
                                transactionBloc.add(
                                    GetTransactions(nodeAddress: nodeAddress));
                              },
                              child: Text('View all', style: AppText.b2),
                            ),
                          ],
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
