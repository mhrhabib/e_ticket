import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomDropdownShimmer extends StatelessWidget {
  const CustomDropdownShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 58.0,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
