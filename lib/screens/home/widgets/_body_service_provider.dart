part of '../home.dart';

class _BodyServiceProvider extends StatelessWidget {
  const _BodyServiceProvider();

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
      bottomNavigationBar: const BottomBar(),
      body: Padding(
        padding: Space.all(),
        child: Column(
          children: [JobCard(job: jobs[0],)],
        ),
      ),
    );
  }
}
