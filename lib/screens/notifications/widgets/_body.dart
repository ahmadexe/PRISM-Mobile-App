part of '../notifications.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {

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
              Space.y2!,
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
            ],
          ),
        ),
      ),
    );
  }
}
