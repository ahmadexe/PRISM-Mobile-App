import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:prism/configs/configs.dart';
import 'package:prism/static/app_statics.dart';

class Avatar extends StatelessWidget {
  final double? radius;
  final String? imageUrl;
  const Avatar({super.key, this.radius, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint('Avatar tapped');
      },
      child: CircleAvatar(
        radius: radius ?? AppDimensions.normalize(7),
        backgroundImage: imageUrl != null
            ? CachedNetworkImageProvider(
                imageUrl!,
              )
            : const AssetImage(
                AppStaticData.dpDef,
              ) as ImageProvider<Object>,
      ),
    );
  }
}
