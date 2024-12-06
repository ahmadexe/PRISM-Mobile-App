part of '../chatbot.dart';

class _NoMessages extends StatelessWidget {
  const _NoMessages();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppStaticData.chatbot,
          height: AppDimensions.normalize(140),
          width: AppDimensions.normalize(140),
        ),
        Space.y2!,
        BlocBuilder<LensBloc, LensState>(
          builder: (context, state) {
            if (state.isSupercharged) {
              return Text(
                'Lens is supercharged! 🔥',
                style: AppText.h1b,
              );
            }
            return Text(
              ' Hi!, I am Lens.',
              style: AppText.h1b,
            );
          },
        ),
        Space.y!,
        Text(
          'Lens is your personal assistant that helps you with your queries. Get started by asking a question.',
          style: AppText.b2!.cl(Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
