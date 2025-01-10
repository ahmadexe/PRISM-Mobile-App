part of '../chatbot.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context, true);
    final lensBloc = BlocProvider.of<LensBloc>(context);
    final chainBloc = BlocProvider.of<BlockchainBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lens'),
          scrolledUnderElevation: 0,
        ),
        body: Padding(
          padding: Space.all(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  lensBloc.add(SuperchargeLensToggle(
                      data: chainBloc.state.analyticalData ?? []));
                  authBloc.add(ToggleSupercharge(id: authBloc.state.user!.id));
                  if (!authBloc.state.user!.isSupercharged) {
                    final nodeAddress = chainBloc.state.address!;
                    chainBloc.add(GetData(nodeAddress: nodeAddress));
                  }
                },
                child: Row(
                  children: [
                    Image.asset(
                      AppStaticData.lensIcon,
                      height: AppDimensions.normalize(17),
                      width: AppDimensions.normalize(17),
                    ),
                    Space.x!,
                    if (authBloc.state.user!.isSupercharged)
                      Text(
                        'Lens Supercharged! 🚀',
                        style: AppText.b1!,
                      )
                    else
                      Text(
                        'Supercharge Lens? 🚀',
                        style: AppText.b1,
                      ),
                  ],
                ),
              ),
              BlocBuilder<LensBloc, LensState>(
                builder: (context, state) {
                  final data = state.messages ?? [];
                  if (data.isEmpty) {
                    return const Expanded(child: _NoMessages());
                  }
                  return Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            padding: Space.all(),
                            reverse: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final message = data[index];
                              return _MessageBubble(message: message);
                            },
                            separatorBuilder: (context, index) => Space.y2!,
                          ),
                        ),
                        if (state.response is LensLoading) ...[
                          Space.y2!,
                          Padding(
                            padding: Space.all(),
                            child: const TypingIndicator(
                              showIndicator: true,
                            ),
                          )
                        ],
                      ],
                    ),
                  );
                },
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Iconsax.export_1,
                      size: AppDimensions.normalize(10),
                      color: AppTheme.c.white,
                    ),
                  ),
                  Space.x!,
                  Expanded(
                    child: FormBuilder(
                      key: screenState.formKey,
                      child: AppTextField(
                        name: _FormKeys.message,
                        hint: 'Message Lens',
                        type: FieldType.secondary,
                        isDarkField: true,
                        onChanged: (v) {
                          if (v != null && v.isNotEmpty) {
                            screenState.setWriting(true);
                          } else {
                            screenState.setWriting(false);
                          }
                        },
                      ),
                    ),
                  ),
                  Space.x!,
                  GestureDetector(
                    onTap: () {
                      if (!screenState.isWriting) return;
                      final form = screenState.formKey.currentState!;
                      form.save();
                      final message = form.value[_FormKeys.message] as String;
                      final prompt = LensMessage(
                          message: message,
                          isFromLens: false,
                          time: DateTime.now());

                      lensBloc.add(GenerateContent(prompt: prompt));

                      form.reset();
                    },
                    child: Icon(
                      Iconsax.send_2,
                      size: AppDimensions.normalize(10),
                      color: screenState.isWriting
                          ? AppTheme.c.primary
                          : AppTheme.c.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
