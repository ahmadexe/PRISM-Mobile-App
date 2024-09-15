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
              BlocBuilder<JobsBloc, JobsState>(
                builder: (context, state) {
                  if (state.fetch is FetchJobsLoading ||
                      state.fetch is FetchJobsInitial) {
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
