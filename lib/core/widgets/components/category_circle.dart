/// lib/core/widgets/components/category_circle.dart
/// 100% RESPECTS YOUR REAL CategoryModel (iconUrl is String?)

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kingsbazar/core/constants/app_colors.dart';
import 'package:kingsbazar/models/category_model.dart';

class CategoryCircle extends StatelessWidget {
  final CategoryModel category;
  final bool isSelected;
  final VoidCallback? onTap;
  final double size;

  const CategoryCircle({
    Key? key,
    required this.category,
    this.isSelected = false,
    this.onTap = null,
    this.size = 76.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Default fallback URL if iconUrl is null
    final String imageUrl = category.iconUrl ??
        'https://img.icons8.com/color/96/shopping-cart.png';

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          // Circle Avatar
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: size.w,
            height: size.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppColors.primary : Colors.grey.shade300,
                width: isSelected ? 3.5 : 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: isSelected
                      ? AppColors.primary.withOpacity(0.25)
                      : Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: (size / 2).w,
              backgroundColor: Colors.grey[100],
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.contain,
                  width: 48.w,
                  height: 48.w,
                  placeholder: (_, __) => Icon(
                    Icons.category_outlined,
                    size: 32.w,
                    color: Colors.grey[400],
                  ),
                  errorWidget: (_, __, ___) => Icon(
                    Icons.broken_image,
                    size: 32.w,
                    color: Colors.grey[400],
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 8.h),

          // Category Name
          SizedBox(
            width: size.w,
            child: Text(
              category.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11.5.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}