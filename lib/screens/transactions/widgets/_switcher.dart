part of '../transactions.dart';

class _Switcher extends StatelessWidget {
  const _Switcher();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Space.v2!,
      child: Container(
        width: double.infinity,
        height: AppDimensions.normalize(25),
        decoration: BoxDecoration(
            color: AppTheme.c.fieldDark,
            borderRadius: BorderRadius.circular(20)),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _SwitcherTab(
              title: 'All Transactions',
              index: 0,
            ),
            _SwitcherTab(
              title: 'My Transactions',
              index: 1,
            ),
          ],
        ),
      ),
    );
  }
}

class _SwitcherTab extends StatelessWidget {
  final String title;
  final int index;
  const _SwitcherTab({required this.title, required this.index});

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context, true);
    return GestureDetector(
      onTap: () => screenState.setSelectedTab(index),
      child: AnimatedContainer(
        width: AppDimensions.normalize(70),
        height: AppDimensions.normalize(20),
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
            color: index == screenState.selectedTab
                ? AppTheme.c.fieldLight
                : AppTheme.c.fieldDark,
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            title,
            style: AppText.b1,
          ),
        ),
      ),
    );
  }
}
