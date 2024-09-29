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
          onPressed: () {
            AppRoutes.createJob.push(context);
          },
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
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
                BlocBuilder<JobsBloc, JobsState>(
                  builder: (context, state) {
                    if (state.myJobs is FetchMyJobsInitial ||
                        state.myJobs is FetchMyJobsLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.myJobs is FetchMyJobsFailure) {
                      return const Center(
                        child: ErrorWarning(
                          title: 'Oops!',
                          message:
                              'Looks like something went wrong. Please try again.',
                        ),
                      );
                    }

                    final jobs = state.myJobs.jobs!;
                    if (jobs.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Space.yf(150.h),
                            Image.asset(
                              AppStaticData.noPostsIcon,
                              height: AppDimensions.normalize(70),
                              width: AppDimensions.normalize(70),
                            ),
                            Space.y!,
                            Text(
                              'Create a Job!',
                              style: AppText.h3b!.cl(AppTheme.c.textGrey!),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: jobs.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (_, __) => Space.y!,
                      itemBuilder: (_, index) => JobCard(job: jobs[index]),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
