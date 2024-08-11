import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CustomSkeletonWidget extends StatelessWidget {
  const CustomSkeletonWidget({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Shimmer(
        color: Colors.blue,
        colorOpacity: 0.1,
        duration: const Duration(seconds: 3),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(14),
          ),
          width: double.infinity,
          height: height,
        ),
      ),
    );
  }
}
