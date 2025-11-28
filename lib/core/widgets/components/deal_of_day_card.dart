/// lib/core/widgets/components/deal_of_day_card.dart
/// PREMIUM "Deal of the Day" Card – Red banner, countdown timer, gold star, your exact design

// ignore_for_file: unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kingsbazar/core/constants/app_colors.dart';
import 'package:kingsbazar/models/product_model.dart';

class DealOfTheDayCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;

  const DealOfTheDayCard({
    Key? key,
    required this.product,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final discountedPrice = product.price - (product.price * product.discountPercentage / 100);
    final savings = product.price * product.discountPercentage / 100;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Main Card Content
            Row(
              children: [
                // Product Image
                Container(
                  width: 140.w,
                  height: 180.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      bottomLeft: Radius.circular(20.r),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      bottomLeft: Radius.circular(20.r),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: product.thumbnail,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(color: Colors.grey[200]),
                      errorWidget: (_, __, ___) => Icon(Icons.image, size: 50.w, color: Colors.grey),
                    ),
                  ),
                ),

                // Details
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Gold Star + Deal Label
                        Row(
                          children: [
                            Icon(Icons.star_rounded, color: AppColors.accent, size: 20.w),
                            SizedBox(width: 6.w),
                            Text(
                              "Deal of the Day",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),

                        // Product Title
                        Text(
                          product.title,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8.h),

                        // Rating
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16.w),
                            SizedBox(width: 4.w),
                            Text(
                              product.rating.toStringAsFixed(1),
                              style: TextStyle(fontSize: 13.sp),
                            ),
                            Text(
                              " (${(product.rating * 100).toInt()}+)",
                              style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),

                        // Price Row
                        Row(
                          children: [
                            Text(
                              "₹${discountedPrice.toStringAsFixed(0)}",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              "₹${product.price.toStringAsFixed(0)}",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Text(
                                "-${product.discountPercentage.toStringAsFixed(0)}%",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),

                        // Countdown Timer
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.access_time, color: Colors.white, size: 16.w),
                              SizedBox(width: 6.w),
                              Text(
                                "Ends in 06:23:45",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Top Red Banner
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 36.h,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                child: Center(
                  child: Text(
                    "DEAL OF THE DAY",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ),

            // Crown Badge
            Positioned(
              top: 8.h,
              right: 12.w,
              child: Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2)),
                  ],
                ),
                child: Icon(Icons.auto_awesome, color: Colors.white, size: 18.w),
              ),
            ),
          ],
        ),
      ),
    );
  }
}