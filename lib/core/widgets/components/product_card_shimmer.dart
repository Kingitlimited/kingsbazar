  
/// lib/core/widgets/components/product_card_shimmer.dart
/// BEAUTIFUL SHIMMER FOR PRODUCT GRID — Matches your exact design

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kingsbazar/core/constants/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[100]!,
      highlightColor: Colors.grey[50]!,
      child: Container(
        width: 165.w,
        margin: EdgeInsets.only(right: 12.w, bottom: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: Colors.grey.shade200, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Placeholder
            Stack(
              children: [
                Container(
                  height: 160.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
                  ),
                ),
                // Wishlist Heart Placeholder
                Positioned(
                  top: 10.h,
                  right: 10.w,
                  child: Container(
                    width: 36.w,
                    height: 36.w,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                // Discount Badge Placeholder
                Positioned(
                  top: 10.h,
                  left: 10.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Container(
                      width: 40.w,
                      height: 12.h,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Brand Name Placeholder
                  Container(
                    width: 80.w,
                    height: 14.h,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 6.h),

                  // Title Placeholder
                  Container(
                    width: double.infinity,
                    height: 14.h,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    width: 100.w,
                    height: 14.h,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 12.h),

                  // Rating Row Placeholder
                  Row(
                    children: [
                      Container(
                        width: 60.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: Colors.amber.shade100,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(width: 60.w, height: 12.h, color: Colors.grey[300]),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  // Price Row Placeholder
                  Row(
                    children: [
                      Container(
                        width: 80.w,
                        height: 20.h,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 8.w),
                      Container(width: 60.w, height: 16.h, color: Colors.grey[300]),
                      SizedBox(width: 8.w),
                      Container(
                        width: 50.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────
// GRID SHIMMER (USE IN HOME/CATEGORY)
// ─────────────────────────────────────
class ProductGridShimmer extends StatelessWidget {
  final int itemCount;

  const ProductGridShimmer({Key? key, this.itemCount = 6}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 16.h,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) => const ProductCardShimmer(),
    );
  }
}