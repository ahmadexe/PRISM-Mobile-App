import 'package:flutter/material.dart';
import 'package:prism/configs/configs.dart';
import 'package:shimmer/shimmer.dart';

class PostPlaceHolder extends StatelessWidget {
  const PostPlaceHolder();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: AppDimensions.normalize(6),
                  ),
                  Space.x1!,
                  Container(
                    color: Colors.grey,
                    height: 2,
                    width: AppDimensions.normalize(30),
                  )
                ],
              ),
              Space.y1!,
              Container(
                color: Colors.grey,
                height: AppDimensions.normalize(.2),
              ),
              Space.y!,
              Container(
                color: Colors.grey,
                height: AppDimensions.normalize(.2),
              ),
              Space.y!,
              Container(
                color: Colors.grey,
                height: AppDimensions.normalize(.2),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) => Space.yf(50),
        itemCount: 5,
      ),
    );
  }
}
