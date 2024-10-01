part of '../jobs_detail.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final jobsBloc = BlocProvider.of<JobsBloc>(context);

    final authBloc = BlocProvider.of<AuthBloc>(context);
    final user = authBloc.state.user!;

    final screenState = _ScreenState.s(context, true);
    final job = screenState.job;

    final jobProvider = Provider.of<JobProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Job Details'),
          scrolledUnderElevation: 0,
        ),
        body: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: Space.all(),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Avatar(imageUrl: job.avatar),
                            Space.x1!,
                            Text(job.username, style: AppText.h1bm),
                          ],
                        ),
                        Space.y1!,
                        Row(
                          children: [
                            const Icon(
                              Iconsax.location,
                              color: Colors.grey,
                              size: 15,
                            ),
                            Space.x!,
                            Text(
                              job.country,
                              style: AppText.b2!.cl(Colors.grey),
                            ),
                          ],
                        ),
                        Space.y2!,
                        Text(job.title, style: AppText.h2bm),
                        Space.y1!,
                        Text(
                          'Posted ${DateTime.now().getDifference(job.postedAt)} ago',
                          style: AppText.b2!.cl(Colors.grey),
                        ),
                        Space.y1!,
                        Text(job.description, style: AppText.b1),
                        const AppDivider(),
                        Text(
                          'Skills & Expertise',
                          style: AppText.h2bm,
                        ),
                        Space.y1!,
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: List.generate(
                            job.keywords.length,
                            (index) {
                              final keyword = job.keywords[index];
                              return Chip(
                                label: Text(keyword,
                                    style: AppText.l1!.cl(Colors.white)),
                                backgroundColor: AppTheme.c.fieldLight!,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              );
                            },
                          ),
                        ),
                        const AppDivider(),
                        Text(
                          'Budget & Payment',
                          style: AppText.h2bm,
                        ),
                        Space.y1!,
                        Row(
                          children: [
                            const Icon(
                              Iconsax.dollar_circle,
                              size: 19,
                            ),
                            Space.x!,
                            Text(
                              '${job.budget} USD ${job.budgetMeta}',
                              style: AppText.b1!,
                            ),
                          ],
                        ),
                        Space.y1!,
                        Row(
                          children: [
                            const Icon(
                              Iconsax.card_coin,
                              size: 19,
                            ),
                            Space.x!,
                            Text(
                              '10 Prism Coins',
                              style: AppText.b1!,
                            ),
                          ],
                        ),
                        Space.y1!,
                      ],
                    ),
                  ),
                ),
              ),
              if (user.id != job.postedBy) ...[
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: AppTheme.c.background,
                    child: Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            label: 'Apply',
                            onPressed: () {
                              jobsBloc.add(
                                ApplyForJob(
                                  jobId: job.id,
                                  userId: user.id,
                                  username: user.fullname,
                                  avatar: user.imageUrl,
                                ),
                              );
                            },
                          ),
                        ),
                        Space.x1!,
                        Expanded(
                          child: AppButton(
                            icon: screenState.isJobLiked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            label: screenState.isJobLiked ? 'Liked' : 'Like',
                            onPressed: () {
                              screenState.toggleLike();
                              jobsBloc.add(
                                LikeUnlikeJob(jobId: job.id, userId: user.id),
                              );
                            },
                            buttonType: ButtonType.bordered,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                BlocConsumer<JobsBloc, JobsState>(
                  listener: (context, state) {
                    if (state.apply is ApplyForJobSuccess) {
                      SnackBars.success(
                          context, 'Applied for job successfully');
                      ''.pop(context);
                    } else if (state.apply is ApplyForJobFailure) {
                      SnackBars.failure(
                        context,
                        'Failed to apply for job, try again.',
                      );
                    }
                  },
                  builder: (context, state) {
                    return BlocBuilder<JobsBloc, JobsState>(
                      builder: (context, state) {
                        if (state.apply is ApplyForJobLoading) {
                          return const FullScreenLoader();
                        }
                        return const SizedBox();
                      },
                    );
                  },
                ),
              ] else ...[
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: AppTheme.c.background,
                    child: AppButton(
                      label: 'View Applications',
                      onPressed: () {
                        jobProvider.selectJob(job);
                        jobsBloc.add(FetchApplications(id: job.id));
                        AppRoutes.viewApplications.push(context);
                      },
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
