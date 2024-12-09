part of '../resume_analysis.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final mediaProvider = MediaProvider.s(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Resume"),
          scrolledUnderElevation: 0,
        ),
        body: Stack(
          children: [
            Padding(
              padding: Space.all(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Space.yf(50),
                  BlocBuilder<LensBloc, LensState>(
                    builder: (context, state) {
                      if (state.skills is SkillExtractionSuccess) {
                        final skills = state.skills.skills ?? [];
                        if (skills.isEmpty) {
                          return const ErrorWarning(
                            title: 'Hmmmmm..',
                            message:
                                'Seems like you have a skill issue, maybe try with a different picture?',
                          );
                        }
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                'Lens has analyzed your resume!',
                                style: AppText.h3b,
                                textAlign: TextAlign.center,
                              ),
                              Space.y!,
                              Text(
                                'Lens has indentified the following skills in your resume, we will use this information to find the best job for you.',
                                style: AppText.l1,
                                textAlign: TextAlign.center,
                              ),
                              Space.y2!,
                              Wrap(
                                spacing: AppDimensions.normalize(5),
                                children: skills
                                    .map(
                                      (skill) => Chip(
                                        label: Text(skill),
                                        backgroundColor: AppTheme.c.primary,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const Spacer(),
                  AppButton(
                    label: 'Get Started!',
                    onPressed: () {
                      mediaProvider.removeInputImage();
                      mediaProvider.removeMedia();
                      AppRoutes.generateWallet.clearStackAndPush(context);
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<LensBloc, LensState>(
              builder: (context, state) {
                if (state.skills is SkillExtractionLoading) {
                  return const FullScreenLoader();
                } else {
                  return const SizedBox.shrink();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
