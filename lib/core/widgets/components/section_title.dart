/// lib/core/widgets/components/section_title.dart
/// PREMIUM SECTION TITLE – Matches your exact design: Red "View All", Gold underline

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kingsbazar/core/constants/app_colors.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAll;
  final bool showViewAll;
  final Color? textColor;
  final double fontSize;

  const SectionTitle({
    Key? key,
    required this.title,
    this.onViewAll,
    this.showViewAll = true,
    this.textColor,
    this.fontSize = 20.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title + Gold Underline
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: fontSize.sp,
                  fontWeight: FontWeight.bold,
                  color: textColor ?? AppColors.textPrimary,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 6.h),
              Container(
                width: 60.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ],
          ),

          // View All Button
          if (showViewAll)
            GestureDetector(
              onTap: onViewAll,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.3),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "VIEW ALL",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.primary,
                      size: 14.w,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────
// QUICK PRESETS (Most Used)
// ─────────────────────────────────────

// Default (Most Sections)
class DefaultSectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const DefaultSectionTitle({Key? key, required this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SectionTitle(title: title, onViewAll: onTap);
  }
}

// Large Title (Home Page Hero)
class LargeSectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const LargeSectionTitle({Key? key, required this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SectionTitle(
      title: title,
      onViewAll: onTap,
      fontSize: 24,
    );
  }
}

// Without View All (Deal of the Day, etc.)
class SimpleSectionTitle extends StatelessWidget {
  final String title;
  const SimpleSectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SectionTitle(title: title, showViewAll: false);
  }
}