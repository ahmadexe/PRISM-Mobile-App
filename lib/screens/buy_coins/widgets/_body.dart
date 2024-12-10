part of '../buy_coins.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context, true);
    final chainBloc = BlocProvider.of<BlockchainBloc>(context);

    return BlocListener<BlockchainBloc, ChainState>(
      listener: (context, state) {
        if (state.buy is BuyCoinsSuccess) {
          SnackBars.success(context, "Coins bought successfully, please wait for the mining!");
          ''.pop(context);
        } else if (state.buy is BuyCoinsFailure) {
          SnackBars.failure(context, "Failed to buy coins");
        }
      },
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Buy Coins'),
              scrolledUnderElevation: 0,
            ),
            body: Center(
              child: Padding(
                padding: Space.all(),
                child: FormBuilder(
                  key: screenState.formKey,
                  child: BlocBuilder<BlockchainBloc, ChainState>(
                    builder: (context, state) {
                      if (state.buy is BuyCoinsLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Column(
                        children: [
                          SvgPicture.asset(
                            AppStaticData.logoSvg,
                            height: AppDimensions.normalize(70),
                            width: AppDimensions.normalize(70),
                          ),
                          Space.yf(50),
                          AppTextField(
                            name: _FormKeys.amount,
                            hint: 'Enter amount in \$',
                            label: 'Amount',
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.numeric(),
                            ]),
                            isDarkField: true,
                          ),
                          Space.y2!,
                          AppButton(
                            label: 'Buy Coins',
                            buttonType: ButtonType.borderedSecondary,
                            onPressed: () async {
                              final form = screenState.formKey.currentState;
                              final isValid = form!.saveAndValidate();
                              if (!isValid) return;

                              final amountRaw =
                                  form.value[_FormKeys.amount] as String;
                              final amount = int.parse(amountRaw);

                              final isSuccessful = await StripeService.instance
                                  .makePayment(amount);

                              if (isSuccessful) {
                                final cache = AppCache();
                                final chainAddress =
                                    await cache.getString('ChainAddress');

                                if (chainAddress != null) {
                                  chainBloc.add(BuyCoins(
                                    nodeAddress: chainBloc.state.address!,
                                    amount: amount.toDouble(),
                                    userChainAddress: chainAddress,
                                  ));
                                }
                              }
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
