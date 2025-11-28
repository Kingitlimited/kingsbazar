/// lib/core/widgets/components/product_card.dart
/// FINAL VERSION — NOW USING YOUR PriceTag & IconActionButton — 100% REUSABLE

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kingsbazar/core/constants/app_colors.dart';
import 'package:kingsbazar/core/widgets/common/custom_button.dart';
import 'package:kingsbazar/core/widgets/common/price_tag.dart';
import 'package:kingsbazar/core/widgets/components/rating_stars.dart';
import 'package:kingsbazar/models/product_model.dart';
import 'package:kingsbazar/providers/wishlist_provider.dart';

class ProductCard extends ConsumerWidget {
  final ProductModel product;
  final VoidCallback? onTap;

  const ProductCard({
    Key? key,
    required this.product,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isWishlisted = ref.watch(isInWishlistProvider(product.id));
    final discountedPrice = product.price - (product.price * product.discountPercentage / 100);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 165.w,
        margin: EdgeInsets.only(right: 12.w, bottom: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 16, offset: Offset(0, 6)),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                  child: CachedNetworkImage(
                    imageUrl: product.thumbnail,
                    height: 160.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(color: Colors.grey[200]),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.brand.toUpperCase(),
                        style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade600, fontWeight: FontWeight.w600),
                        maxLines: 1,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        product.title,
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, height: 1.3),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.h),
                      SmallRatingStars(rating: product.rating),
                      SizedBox(height: 10.h),

                      // NOW USING YOUR PRICE TAG — PERFECT
                      PriceTag(
                        price: discountedPrice,
                        originalPrice: product.discountPercentage > 0 ? product.price : null,
                        alignment: MainAxisAlignment.start,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Wishlist Heart — NOW USING YOUR IconActionButton
            Positioned(
              top: 8.h,
              right: 8.w,
              child: IconActionButton(
                icon: isWishlisted ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                isActive: isWishlisted,
                onTap: () => ref.read(wishlistProvider.notifier).toggle(product),
              ),
            ),

            // Crown Badge (Featured)
            if (product.rating >= 4.7)
              Positioned(
                top: 10.h,
                right: 10.w,
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                  child: Icon(Icons.auto_awesome, color: Colors.white, size: 16.w),
                ),
              ),
          ],
        ),
      ),
    );
  }
}