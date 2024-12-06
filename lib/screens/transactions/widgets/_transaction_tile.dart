part of '../transactions.dart';

class _TransactionTile extends StatelessWidget {
  final PublicTransaction transaction;
  const _TransactionTile({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppDimensions.normalize(35),
      decoration: BoxDecoration(
        color: AppTheme.c.fieldLight,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: Space.all(),
        child: Row(
          children: [
            SvgPicture.asset(
              AppStaticData.logoSvg,
              height: AppDimensions.normalize(20),
              width: AppDimensions.normalize(20),
            ),
            Space.x2!,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(transaction.senderChainAddress, style: AppText.b1),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("To: ${transaction.recipientChainAddress}",
                          style: AppText.l1),
                      Space.x2!,
                      Text(
                        transaction.value.toString(),
                        style: AppText.b2b!.cl(
                          [AppTheme.c.accent, AppTheme.c.primary]
                              .elementAt(Random().nextInt(2))!,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
