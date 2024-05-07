import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:prism/configs/configs.dart';
import 'package:prism/router/routes.dart';
import 'package:prism/utils/domain/domain_icon.dart';

class InfoTile extends StatelessWidget {
  final String domain;
  final bool isEdit;
  final bool iconOnly;
  const InfoTile(
      {super.key,
      this.isEdit = false,
      this.domain = '',
      this.iconOnly = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isEdit) {
          AppRoutes.editProfile.push(context);
        }
      },
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          color: AppTheme.c.fieldLight!.withOpacity(.75),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: Space.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                isEdit ? Iconsax.path : getIcon(domain),
                size: 20,
                color: AppTheme.c.accent,
              ),
              if (!iconOnly) ...[
                Space.x!,
                Text(
                  isEdit ? 'Edit' : domain,
                  style: AppText.l1bm,
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
