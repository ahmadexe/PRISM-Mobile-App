part of '../bottom_bar.dart';

class _AnimatedBar extends StatelessWidget {
  final bool isActive;
  const _AnimatedBar({required this.isActive});

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      margin: const EdgeInsets.only(bottom: 2),
      width: isActive ? AppDimensions.normalize(10) : 0,
      height: 4,
      decoration: BoxDecoration(
        color: AppTheme.c.primary,
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}
