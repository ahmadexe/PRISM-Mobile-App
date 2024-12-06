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
        body: Column(
          children: [
            const _Switcher(),
            BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
                if (state.getTransactions is GetTransactionsLoading ||
                    state.getTransactions is GetTransactionsDefault) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.getTransactions is GetTransactionsFailure) {
                  return const Center(
                    child: ErrorWarning(
                        title: 'Hmmm',
                        message: 'An error occured, we are working on it'),
                  );
                }

                final transactions = state.transactions!;
                return Expanded(
                  child: ListView.separated(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = transactions[index];
                      return _TransactionTile(transaction: transaction);
                    },
                    separatorBuilder: (context, index) => Space.y2!,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
