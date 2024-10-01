part of '../wallet.dart';

class _BalanceCard extends StatelessWidget {
  final double balance;
  const _BalanceCard({required this.balance});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.normalize(90),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          AppTheme.c.fieldDark!,
          AppTheme.c.fieldLight!,
        ]),
        borderRadius: BorderRadius.circular(AppDimensions.normalize(10)),
      ),
      child: Padding(
        padding: Space.all(AppDimensions.normalize(20), 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Space.yf(AppDimensions.normalize(5)),
            Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                AppStaticData.coin,
                height: AppDimensions.normalize(30),
                width: AppDimensions.normalize(30),
              ),
            ),
            Text(
              'Balance',
              style: AppText.h3b,
            ),
            Space.y!,
            Row(
              children: [
                SvgPicture.asset(
                  AppStaticData.logoSvg,
                  height: AppDimensions.normalize(10),
                  width: AppDimensions.normalize(10),
                ),
                Space.x!,
                Text(
                  balance.toStringAsFixed(2),
                  style: AppText.h2bm,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
