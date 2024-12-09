part of '../generate_wallet.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context, true);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Generate Wallet'),
          scrolledUnderElevation: 0,
          actions: [
            BlocBuilder<BlockchainBloc, ChainState>(
              builder: (context, state) {
                if (state.node is NodeSuccess) {
                  return TextButton(
                    onPressed: () {
                      final walletBloc = BlocProvider.of<WalletBloc>(context);
                      walletBloc
                          .add(GetWalletDetails(nodeAddress: state.address!));
                      AppRoutes.home.pushReplace(context);
                    },
                    child: Text(
                      'Skip',
                      style: AppText.b1bm!.cl(AppTheme.c.primary!),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
        body: Padding(
          padding: Space.all(),
          child: SingleChildScrollView(
            child: FormBuilder(
              key: screenState.formKey,
              child: BlocBuilder<BlockchainBloc, ChainState>(
                builder: (context, state) {
                  if (state.node is NodeLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Space.yf(90),
                      Image.asset(
                        AppStaticData.wallet,
                        height: AppDimensions.normalize(70),
                        width: AppDimensions.normalize(70),
                        fit: BoxFit.cover,
                      ),
                      Space.yf(50),
                      AppTextField(
                        name: _FormKeys.publicKey,
                        prefixIcon: Icon(
                          Iconsax.lock,
                          size: AppDimensions.normalize(7),
                        ),
                        hint: 'Enter Public Key',
                        isDarkField: true,
                        type: FieldType.secondary,
                      ),
                      Space.y2!,
                      AppTextField(
                        name: _FormKeys.privateKey,
                        prefixIcon: Icon(
                          Iconsax.lock,
                          size: AppDimensions.normalize(7),
                        ),
                        hint: 'Enter Private Key',
                        isDarkField: true,
                        type: FieldType.secondary,
                      ),
                      Space.y2!,
                      AppTextField(
                        name: _FormKeys.address,
                        prefixIcon: Icon(
                          Iconsax.lock,
                          size: AppDimensions.normalize(7),
                        ),
                        hint: 'Enter Blockchain Address',
                        isDarkField: true,
                        type: FieldType.secondary,
                      ),
                      Space.yf(50),
                      AppButton(
                          label: "Let's Go!",
                          onPressed: () {
                            final form = screenState.formKey.currentState;
                            final isValid = form!.saveAndValidate();
                            if (!isValid) return;

                            final publicKey =
                                form.value[_FormKeys.publicKey] as String;
                            final privateKey =
                                form.value[_FormKeys.privateKey] as String;
                            final address =
                                form.value[_FormKeys.address] as String;

                            final nodeBloc =
                                BlocProvider.of<BlockchainBloc>(context);
                            BlocProvider.of<WalletBloc>(context)
                                .add(GetWalletDetails(
                              nodeAddress: nodeBloc.state.address!,
                              publicKey: publicKey,
                              privateKey: privateKey,
                              address: address,
                            ));

                            AppRoutes.home.pushReplace(context);
                          }),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
