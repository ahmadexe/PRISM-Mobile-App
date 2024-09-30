part of '../notifications.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context, true);

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const BottomBar(),
        appBar: AppBar(
          title: const Text('Notifications'),
          scrolledUnderElevation: 0,
        ),
        body: Padding(
          padding: Space.all(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          screenState.setIndex(0);
                        },
                        child: Text(
                          'Notifications',
                          style: AppText.h3bm,
                        ),
                      ),
                      if (screenState.index == 0)
                        AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          height: 2,
                          width: 100.w,
                          color: AppTheme.c.primary,
                        ),
                    ],
                  ),
                  Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          screenState.setIndex(1);
                        },
                        child: Text(
                          'Applications',
                          style: AppText.h3bm,
                        ),
                      ),
                      if (screenState.index == 1)
                        AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          height: 2,
                          width: 100.w,
                          color: AppTheme.c.primary,
                        ),
                    ],
                  ),
                ],
              ),
              Space.y2!,
              if (screenState.index == 0)
                BlocBuilder<NotificationsBloc, NotificationsState>(
                  builder: (context, state) {
                    if (state.fetch is FetchNotificationLoading ||
                        state.fetch is FetchNotificationDefault) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state.fetch is FetchNotificationSuccess) {
                      final notis = state.data ?? [];
                      return ListView.builder(
                        itemCount: notis.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final noti = notis[index];
                          return _NotificationTile(notification: noti);
                        },
                      );
                    } else {
                      return const ErrorWarning(
                        title: 'Oops!',
                        message: 'Could not fetch notifications',
                      );
                    }
                  },
                )
              else
                BlocBuilder<JobsBloc, JobsState>(
                  builder: (context, state) {
                    return const ErrorWarning(
                      title: 'Oops!',
                      message: 'Could not fetch applications',
                    );
                  },
                )
            ],
          ),
        ),
      ),
    );
  }
}
