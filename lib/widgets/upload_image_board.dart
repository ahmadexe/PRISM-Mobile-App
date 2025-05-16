import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:prism/configs/configs.dart';
import 'package:prism/providers/media_provider.dart';
import 'package:prism/widgets/pick_image_modal.dart';

class UploadImageBoard extends StatelessWidget {
  const UploadImageBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaProvider = MediaProvider.s(context, true);
    return Column(
      children: [
        if (mediaProvider.media != null) ...[
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(mediaProvider.media!.path),
                  height: AppDimensions.normalize(150),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: .5),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: AppDimensions.normalize(150),
                width: double.infinity,
              ),
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                bottom: 0,
                child: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => const PickImageModal(),
                    );
                  },
                  icon: const Icon(
                    Iconsax.image,
                    size: 50,
                  ),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ] else ...[
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => const PickImageModal(),
              );
            },
            child: Center(
              child: Container(
                width: double.infinity,
                height: AppDimensions.normalize(150),
                decoration: BoxDecoration(
                  color: AppTheme.c.fieldDark,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Iconsax.image,
                        size: 50,
                      ),
                      Space.y2!,
                      Center(
                        child: Text(
                          'Add media',
                          style: AppText.b1bm,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
