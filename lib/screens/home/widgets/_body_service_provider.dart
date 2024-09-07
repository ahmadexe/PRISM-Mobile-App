part of '../home.dart';

class _BodyServiceProvider extends StatelessWidget {
  const _BodyServiceProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
              onPressed: () => AppRoutes.conversations.push(context),
              icon: const Icon(Iconsax.sms_tracking),
            ),
          ],
          scrolledUnderElevation: 0,
        ),
        drawer: const _Drawer(),
        body: const Column(
          children: [
            Text('Service Provider'),
          ],
        ),
    );
  }
}