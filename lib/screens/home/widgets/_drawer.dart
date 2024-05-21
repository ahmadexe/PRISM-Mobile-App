part of '../home.dart';

class _Drawer extends StatelessWidget {
  const _Drawer();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final user = authBloc.state.user!;
    final appMedia = MediaQuery.sizeOf(context);

    return SizedBox(
      width: appMedia.width * 0.65,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppTheme.c.fieldDark,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Avatar(
                    imageUrl: user.imageUrl,
                  ),
                  Space.y1!,
                  Text(
                    user.fullname,
                    style: AppText.b1bm,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    user.email,
                    style: AppText.b2,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Iconsax.box_2,
                size: AppDimensions.normalize(7),
              ),
              title: const Text('Analytics'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Iconsax.trend_up,
                size: AppDimensions.normalize(7),
              ),
              title: const Text('Marketplace'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Iconsax.briefcase,
                size: AppDimensions.normalize(7),
              ),
              title: const Text('Jobs'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Iconsax.truck_fast,
                size: AppDimensions.normalize(7),
              ),
              title: const Text('Services'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Iconsax.card_coin,
                size: AppDimensions.normalize(7),
              ),
              title: const Text('PRISM Coin'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Iconsax.wallet,
                size: AppDimensions.normalize(7),
              ),
              title: const Text('Wallet'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
