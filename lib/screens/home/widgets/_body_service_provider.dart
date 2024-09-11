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
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppTextField(
                name: _FormKeys.jobSearch,
                prefixIcon: Icon(
                  Iconsax.search_normal,
                  size: AppDimensions.normalize(7),
                ),
                hint: 'Search',
                isDarkField: true,
                type: FieldType.secondary,
              ),
              Space.y2!,
              ListView.separated(
                itemCount: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (_, __) => Space.y!,
                itemBuilder: (_, index) => JobCard(job: _jobs[0]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
