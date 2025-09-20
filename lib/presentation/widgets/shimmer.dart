import 'package:flutter/material.dart';
import 'package:magical_walls/core/constants/app_colors.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerWidgets {
  static Widget profileShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Shimmer(
              duration: const Duration(seconds: 2),
              interval: const Duration(milliseconds: 300),
              color: Colors.white,
              colorOpacity: 0.3,
              enabled: true,
              direction: const ShimmerDirection.fromLTRB(),
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: CommonColors.textFieldGrey,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                shimmerContainer(150.0, height: 15.0),
                shimmerContainer(100.0, height: 12.0),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        shimmerContainer(200.0, height: 15.0),
        const SizedBox(height: 35),
        shimmerContainer(150.0, height: 15.0),
        const SizedBox(height: 35),
        shimmerContainer(120.0, height: 15.0),
        const SizedBox(height: 35),
        shimmerContainer(100.0, height: 15.0),
        const SizedBox(height: 35),

        shimmerContainer(80.0, height: 15.0),
      ],
    );
  }
  static Widget shimmerBox({double height=150,int count=2} ){
    return ListView.builder(
      itemCount: count,
      shrinkWrap: true,
      itemBuilder: (context ,index){
        return

      Shimmer(
          duration: const Duration(seconds: 2),
          interval: const Duration(milliseconds: 300),
          color: Colors.white,
          colorOpacity: 0.9,
          enabled: true,
          direction: const ShimmerDirection.fromLTRB(),
          child:Container(
            margin: const EdgeInsets.only(bottom: 10,left: 18,right: 18),
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: CommonColors.textFieldGrey.withAlpha(90),
            ),
          ),

      );}
    );
  }

  static Widget shimmerContainer(double width, {double height = 10.0}) {
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
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: CommonColors.textFieldGrey,
        ),
      ),
    );
  }

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
}