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
                    if (state.fetch is FetchJobsLoading ||
                        state.fetch is JobsInitial) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.fetch is FetchJobsFailure) {
                      return const Center(
                        child: ErrorWarning(
                          title: 'Oops!',
                          message:
                              'Looks like something went wrong. Please try again.',
                        ),
                      );
                    }

                    final jobs = state.jobs!;
                    if (jobs.isEmpty) {
                      return const Center(
                        child: Text('No jobs found'),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
