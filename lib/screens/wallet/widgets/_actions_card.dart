part of '../wallet.dart';

class _ActionsCard extends StatelessWidget {
  final bool isTransaction;
  const _ActionsCard({required this.isTransaction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isTransaction) {
          AppRoutes.transaction.push(context);
        }
      },
      child: Container(
        height: AppDimensions.normalize(50),
        width: AppDimensions.normalize(50),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            AppTheme.c.fieldDark!,
            AppTheme.c.fieldLight!,
          ]),
          borderRadius: BorderRadius.circular(AppDimensions.normalize(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isTransaction) ...[
              Image.asset(
                AppStaticData.coin,
                height: AppDimensions.normalize(15),
                width: AppDimensions.normalize(15),
              ),
              Space.y!,
              Text(
                'Send Coins',
                style: AppText.b1b,
              ),
            ] else ...[
              SvgPicture.asset(
                AppStaticData.logoSvg,
                height: AppDimensions.normalize(15),
                width: AppDimensions.normalize(15),
              ),
              Space.y!,
              Text(
                'View Keys',
                style: AppText.b1b,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
