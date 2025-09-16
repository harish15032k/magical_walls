import 'package:flutter/material.dart';
import 'package:magical_walls/core/constants/app_colors.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerWidgets {
  static Widget serviceShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        shimmerContainer(300.0),
        shimmerContainer(250.0),
        shimmerContainer(200.0),
      ],
    );
  }

  static Widget shimmerContainer(double width) {
    return Shimmer(
      duration: const Duration(seconds: 2),
      interval: const Duration(milliseconds: 300),
      color: Colors.white,
      colorOpacity: 0.3,
      enabled: true,
      direction: const ShimmerDirection.fromLTRB(),
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        width: width,
        height: 10.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: CommonColors.textFieldGrey,
        ),
      ),
    );
  }
}
