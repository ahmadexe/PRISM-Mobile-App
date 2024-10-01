part of '../view_applications.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Applications'),
            scrolledUnderElevation: 0,
          ),
          body: Padding(
            padding: Space.all(),
            child: Column(
              children: [
                BlocBuilder<JobsBloc, JobsState>(
                  builder: (context, state) {
                    if (state.applications is FetchApplicationsLoading ||
                        state.applications is FetchApplicationsInitial) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state.applications is FetchApplicationsSuccess) {
                      final applications =
                          (state.applications as FetchApplicationsSuccess)
                              .applications;
                      return Column(
                        children: applications!.map((application) {
                          return GestureDetector(
                            onTap: () {
                              AppRoutes.profile.push(context, arguments: {
                                'userId': application.userId,
                                'isApplicant': true,
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              padding: Space.all(),
                              margin: EdgeInsets.only(bottom: 10.h),
                              decoration: BoxDecoration(
                                color: AppTheme.c.fieldLight!.withOpacity(.7),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Row(
                                children: [
                                  Avatar(imageUrl: application.avatar),
                                  Space.x2!,
                                  Text(application.username, style: AppText.b1),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    } else {
                      return const ErrorWarning(
                          title: 'Oops',
                          message: 'Failed to load applications');
                    }
                  },
                )
              ],
            ),
          )),
    );
  }
}
