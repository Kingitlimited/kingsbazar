 
/// lib/core/widgets/common/price_tag.dart
/// Beautiful, reusable price widgets – used in ProductCard, ProductDetail, Cart, etc.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kingsbazar/core/constants/app_colors.dart';

class PriceTag extends StatelessWidget {
  final double price;
  final double? originalPrice;        // if null → no discount shown
  final double? discountPercentage;   // optional – auto calculated if originalPrice given
  final TextStyle? priceStyle;
  final TextStyle? originalPriceStyle;
  final TextStyle? discountStyle;
  final MainAxisAlignment alignment;

  const PriceTag({
    Key? key,
    required this.price,
    this.originalPrice,
    this.discountPercentage,
    this.priceStyle,
    this.originalPriceStyle,
    this.discountStyle,
    this.alignment = MainAxisAlignment.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasDiscount = originalPrice != null && originalPrice! > price;
    final discount = hasDiscount
        ? (discountPercentage ?? ((originalPrice! - price) / originalPrice! * 100).round())
        : 0;

    return Row(
      mainAxisAlignment: alignment,
      children: [
        // Current Price
        Text(
          '\$${price.toStringAsFixed(price.truncateToDouble() == price ? 0 : 2)}',
          style: priceStyle ??
              TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
        ),

        // Original Price (strikethrough)
        if (hasDiscount) ...[
          SizedBox(width: 8.w),
          Text(
            '\$${originalPrice!.toStringAsFixed(originalPrice!.truncateToDouble() == originalPrice! ? 0 : 2)}',
            style: originalPriceStyle ??
                TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textSecondary,
                  decoration: TextDecoration.lineThrough,
                  decorationThickness: 2,
                ),
          ),

          // Discount Badge
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              '$discount% OFF',
              style: discountStyle ??
                  TextStyle(
                    color: Colors.white,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ],
    );
  }
}

// ──────────────────────────────────────────────────────
// QUICK VARIANTS (use directly)
// ──────────────────────────────────────────────────────

/// Small Price Tag – for Product Cards
class SmallPriceTag extends StatelessWidget {
  final double price;
  final double? originalPrice;

  const SmallPriceTag({Key? key, required this.price, this.originalPrice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PriceTag(
      price: price,
      originalPrice: originalPrice,
      priceStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: AppColors.primary),
      originalPriceStyle: TextStyle(fontSize: 12.sp, color: Colors.grey, decoration: TextDecoration.lineThrough),
      discountStyle: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }
}

/// Large Price Tag – for Product Detail Screen
class LargePriceTag extends StatelessWidget {
  final double price;
  final double? originalPrice;

  const LargePriceTag({Key? key, required this.price, this.originalPrice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PriceTag(
      price: price,
      originalPrice: originalPrice,
      alignment: MainAxisAlignment.start,
      priceStyle: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold, color: AppColors.primary),
      originalPriceStyle: TextStyle(fontSize: 18.sp, color: Colors.grey.shade600, decoration: TextDecoration.lineThrough),
      discountStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }
}

/// Price with "From" – for category pages
class FromPriceTag extends StatelessWidget {
  final double price;
  const FromPriceTag({Key? key, required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('From ', style: TextStyle(fontSize: 14.sp, color: AppColors.textSecondary)),
        Text(
          '\$${price.toStringAsFixed(0)}',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.primary),
        ),
      ],
    );
  }
}