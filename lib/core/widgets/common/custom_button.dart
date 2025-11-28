  
/// lib/core/widgets/common/custom_button.dart
/// All reusable button widgets – pixel-perfect, red theme, fully animated

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kingsbazar/core/constants/app_colors.dart';

/// Primary Red Button (Main CTA – Add to Cart, Buy Now, etc.)
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final double? height;
  final IconData? icon;

  const PrimaryButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.height,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: height ?? 50.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.primary.withOpacity(0.5),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
        ),
        child: isLoading
            ? SizedBox(
                height: 24.h,
                width: 24.w,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20.sp),
                    SizedBox(width: 8.w),
                  ],
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

/// Secondary / Outline Button
class OutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isFullWidth;
  final Color? borderColor;

  const OutlineButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isFullWidth = true,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: 50.h,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: BorderSide(color: borderColor ?? AppColors.primary, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

/// Small Red Text Button (e.g. "View All", "See More")
class SmallTextButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? color;

  const SmallTextButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
      child: Text(
        label,
        style: TextStyle(
          color: color ?? AppColors.primary,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// Icon Button with background (e.g. Wishlist heart)
class IconActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isActive;
  final Color? activeColor;

  const IconActionButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.isActive = false,
    this.activeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30.r),
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: isActive ? (activeColor ?? AppColors.primary).withOpacity(0.1) : Colors.grey.shade100,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isActive ? (activeColor ?? AppColors.primary) : Colors.grey.shade600,
          size: 22.sp,
        ),
      ),
    );
  }
}