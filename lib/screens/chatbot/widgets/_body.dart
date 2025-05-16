part of '../chatbot.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context, true);
    final lensBloc = BlocProvider.of<LensBloc>(context);
    final chainBloc = BlocProvider.of<BlockchainBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context, listen: true);
    final mediaProvider = MediaProvider.s(context, true);

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
                builder: (context, lensState) {
                  final data = lensState.messages ?? [];
                  if (data.isEmpty) {
                    return const Expanded(child: _NoMessages());
                  }
                  return BlocBuilder<BlockchainBloc, ChainState>(
                    builder: (context, chainState) {
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
                            if (lensState.response is LensLoading ||
                                chainState is GetDataLoading) ...[
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
                  );
                },
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => mediaProvider.pickMedia(
                        ImageSource.gallery, MediaUsecase.lens),
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
                  BlocListener<BlockchainBloc, ChainState>(
                    listener: (context, state) async {
                      if (state.getData is GetDataSuccess) {
                        final data = state.analyticalData ?? [];
                        final form = screenState.formKey.currentState!;
                        form.save();
                        final message = form.value[_FormKeys.message] as String;
                        Uint8List? imageData;
                        if (mediaProvider.mediaForLens != null) {
                          imageData =
                              await mediaProvider.mediaForLens!.readAsBytes();
                        }
                        final prompt = AgentMessage(
                          content: message,
                          generatedAt: DateTime.now(),
                          isFromAgent: false,
                          imageData: imageData,
                        );

                        form.reset();
                        mediaProvider.clearMedia(MediaUsecase.lens);

                        final processedData =
                            data.map((e) => e.toString()).join('\n');

                        lensBloc.add(
                          GenerateContent(
                            prompt: prompt,
                            chainData: processedData,
                          ),
                        );
                      }
                    },
                    child: GestureDetector(
                      onTap: () async {
                        if (!screenState.isWriting) return;
                        final form = screenState.formKey.currentState!;
                        form.save();
                        final message = form.value[_FormKeys.message] as String;
                        Uint8List? imageData;
                        if (mediaProvider.mediaForLens != null) {
                          imageData =
                              await mediaProvider.mediaForLens!.readAsBytes();
                        }

                        final prompt = AgentMessage(
                          content: message,
                          generatedAt: DateTime.now(),
                          isFromAgent: false,
                          imageData: imageData,
                        );

                        if (authBloc.state.user!.isSupercharged) {
                          final nodeAddress = chainBloc.state.address!;
                          chainBloc.add(GetData(nodeAddress: nodeAddress));
                        } else {
                          lensBloc.add(GenerateContent(prompt: prompt));
                          form.reset();
                          mediaProvider.clearMedia(MediaUsecase.lens);
                        }
                      },
                      child: Icon(
                        Iconsax.send_2,
                        size: AppDimensions.normalize(10),
                        color: screenState.isWriting
                            ? AppTheme.c.primary
                            : AppTheme.c.white,
                      ),
                    ),
                  ),
                ],
              ),
              if (mediaProvider.mediaForLens != null) ...[
                Space.y!,
                Align(
                  alignment: Alignment.bottomLeft,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      width: AppDimensions.normalize(35),
                      height: AppDimensions.normalize(35),
                      File(mediaProvider.mediaForLens!.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
