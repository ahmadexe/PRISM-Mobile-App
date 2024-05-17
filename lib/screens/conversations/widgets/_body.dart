part of '../conversations.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Conversations'),
          scrolledUnderElevation: 0,
        ),
        body: Padding(
          padding: Space.all(),
          child: Column(
            children: [
              AppTextField(
                name: _FormKeys.search,
                hint: 'Search...',
                suffixIcon: Icon(
                  Iconsax.search_status,
                  size: AppDimensions.normalize(7),
                ),
                type: FieldType.secondary,
              )
            ],
          ),
        ),
      ),
    );
  }
}
