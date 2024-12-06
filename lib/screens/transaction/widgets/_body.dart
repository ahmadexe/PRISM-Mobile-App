part of '../transaction.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context, true);
    final transactionBloc = BlocProvider.of<TransactionBloc>(context);
    final nodeBloc = BlocProvider.of<BlockchainBloc>(context);
    final address = nodeBloc.state.address;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Send Coins'),
          scrolledUnderElevation: 0,
        ),
        body: Padding(
          padding: Space.all(),
          child: FormBuilder(
            key: screenState.formKey,
            child: BlocBuilder<WalletBloc, WalletState>(
              builder: (context, state) {
                if (state.walletInfo is WalletInfoLoading ||
                    state.walletInfo is WalletInfoDefault) {
                  return const FullScreenLoader();
                } else if (state.walletInfo is WalletInfoError) {
                  return const ErrorWarning(
                      title: 'Hmmm',
                      message: 'An error occured, we are working on it');
                }
                final wallet = state.wallet!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      AppStaticData.logoSvg,
                      height: AppDimensions.normalize(40),
                    ),
                    Space.yf(50),
                    AppTextField(
                      name: _FormKeys.publicKey,
                      label: "Public Key",
                      isDarkField: true,
                      isPass: true,
                      initialValue: wallet.publicKey,
                    ),
                    Space.y1!,
                    AppTextField(
                      name: _FormKeys.privateKey,
                      label: "Private Key",
                      isDarkField: true,
                      isPass: true,
                      initialValue: wallet.privateKey,
                    ),
                    Space.y1!,
                    AppTextField(
                      name: _FormKeys.blockchainAddress,
                      label: "Blockchain Address",
                      isDarkField: true,
                      isPass: true,
                      initialValue: wallet.blockchainAddress,
                    ),
                    Space.y1!,
                    const AppTextField(
                      name: _FormKeys.receiverAddress,
                      label: "Receiver Address",
                      isDarkField: true,
                    ),
                    Space.y1!,
                    const AppTextField(
                      name: _FormKeys.amount,
                      label: "Amount",
                      isDarkField: true,
                    ),
                    Space.y2!,
                    AppButton(
                      label: 'Send',
                      onPressed: () {
                        final form = screenState.formKey.currentState!;
                        final isValid = form.saveAndValidate();
                        if (!isValid) return;

                        final data = form.value;
                        final transaction = Transaction(
                          senderPublicKey: data[_FormKeys.publicKey],
                          senderPrivateKey: data[_FormKeys.privateKey],
                          senderBlockchainAddress:
                              data[_FormKeys.blockchainAddress],
                          recipientBlockchainAddress:
                              data[_FormKeys.receiverAddress],
                          value: double.parse(data[_FormKeys.amount]),
                        );

                        transactionBloc.add(
                          CreateTransaction(
                            transaction: transaction,
                            nodeAddress: address!,
                          ),
                        );
                      },
                      buttonType: ButtonType.borderedSecondary,
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
