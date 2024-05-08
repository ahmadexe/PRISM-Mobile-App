part of '../create_post.dart';

class _Body extends StatelessWidget {
  final String? initialText;
  const _Body({required this.initialText});

  @override
  Widget build(BuildContext context) {
    // final screenState = _ScreenState.s(context, true);

    print(initialText);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Post'),
        ),
        body: const Center(
          child: Text(''),
        ),
      ),
    );
  }
}
