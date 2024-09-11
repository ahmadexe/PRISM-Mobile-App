part of '../my_jobs.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Jobs'),
          actions: [
            IconButton(
              onPressed: () => AppRoutes.conversations.push(context),
              icon: const Icon(Iconsax.sms_tracking),
            ),
          ],
          scrolledUnderElevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {}, child: const Icon(Icons.add)),
        bottomNavigationBar: const BottomBar(),
        body: Padding(
          padding: Space.all(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        name: 'search',
                        prefixIcon: Icon(
                          Iconsax.search_normal,
                          size: AppDimensions.normalize(7),
                        ),
                        hint: 'Search',
                        isDarkField: true,
                        type: FieldType.secondary,
                      ),
                    ),
                    Space.x1!,
                    Icon(
                      Iconsax.filter,
                      size: AppDimensions.normalize(7),
                    ),
                  ],
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
      ),
    );
  }
}
