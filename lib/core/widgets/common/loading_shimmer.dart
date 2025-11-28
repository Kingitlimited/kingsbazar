/// lib/core/widgets/common/loading_shimmer.dart
/// Beautiful shimmer loading placeholders – used everywhere (Home, Product List, etc.)

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final Color? baseColor;
  final Color? highlightColor;

  const ShimmerLoading({
    Key? key,
    required this.child,
    required this.isLoading,
    this.baseColor,
    this.highlightColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return child;

    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.shade200,
      highlightColor: highlightColor ?? Colors.grey.shade100,
      period: const Duration(milliseconds: 1200),
      child: child,
    );
  }
}

// ──────────────────────────────────────────────────────
// PRE-BUILT SHIMMER PLACEHOLDERS
// ──────────────────────────────────────────────────────

/// Product Card Shimmer (Grid/List)
class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            height: 180.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          SizedBox(height: 12.h),

          // Title lines
          Container(height: 16.h, width: 120.w, color: Colors.white),
          SizedBox(height: 8.h),
          Container(height: 16.h, width: 80.w, color: Colors.white),

          SizedBox(height: 12.h),

          // Price + Rating
          Row(
            children: [
              Container(height: 20.h, width: 60.w, color: Colors.white),
              SizedBox(width: 12.w),
              Container(height: 16.h, width: 40.w, color: Colors.white),
            ],
          ),

          SizedBox(height: 16.h),

          // Add Button
          Container(
            height: 36.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ],
      ),
    );
  }
}

/// Banner Slider Shimmer
class BannerShimmer extends StatelessWidget {
  const BannerShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemBuilder: (context, index) {
          return Container(
            width: 320.w,
            margin: EdgeInsets.only(right: 12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
          );
        },
      ),
    );
  }
}

/// Category Circle Shimmer
class CategoryCircleShimmer extends StatelessWidget {
  const CategoryCircleShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70.w,
          height: 70.w,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(height: 8.h),
        Container(height: 12.h, width: 60.w, color: Colors.white),
      ],
    );
  }
}

/// List Item Shimmer (for Orders, Addresses, etc.)
class ListItemShimmer extends StatelessWidget {
  const ListItemShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          Container(width: 80.w, height: 80.h, decoration: BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(8.r),
),),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 16.h, width: double.infinity, color: Colors.white),
                SizedBox(height: 8.h),
                Container(height: 14.h, width: 150.w, color: Colors.white),
                SizedBox(height: 8.h),
                Container(height: 14.h, width: 100.w, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Full Page Shimmer (for entire screen loading)
class FullPageShimmer extends StatelessWidget {
  const FullPageShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const BannerShimmer(),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.w,
              ),
              itemCount: 6,
              itemBuilder: (_, i) => const ProductCardShimmer(),
            ),
          ),
        ],
      ),
    );
  }
}