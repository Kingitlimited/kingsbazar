  
/// lib/core/widgets/components/rating_stars.dart
/// BEAUTIFUL RATING STARS – Gold outline, Red fill when active, Your exact design

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kingsbazar/core/constants/app_colors.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final double size;
  final int maxRating;
  final Color activeColor;
  final Color inactiveColor;
  final bool showText;

  const RatingStars({
    Key? key,
    required this.rating,
    this.size = 16.0,
    this.maxRating = 5,
    this.activeColor = AppColors.primary,     // Red fill
    this.inactiveColor = AppColors.accent,    // Gold outline
    this.showText = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Stars
        Row(
          children: List.generate(maxRating, (index) {
            final double starRating = index + 1.0;
            return Padding(
              padding: EdgeInsets.only(right: 2.w),
              child: Icon(
                starRating <= rating
                    ? Icons.star_rounded
                    : starRating - rating <= 0.5
                        ? Icons.star_half_rounded
                        : Icons.star_border_rounded,
                color: starRating <= rating ? activeColor : inactiveColor,
                size: size.w,
              ),
            );
          }),
        ),

        // Rating Number
        if (showText) ...[
          SizedBox(width: 6.w),
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            " / $maxRating",
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ],
    );
  }
}

// ─────────────────────────────────────
// PRESET VARIANTS (Most Used in App)
// ─────────────────────────────────────

// Small Red + Gold Stars (Product Card)
class SmallRatingStars extends StatelessWidget {
  final double rating;
  const SmallRatingStars({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingStars(
      rating: rating,
      size: 14,
      showText: false,
    );
  }
}

// Medium with Text (Product Detail)
class MediumRatingStars extends StatelessWidget {
  final double rating;
  const MediumRatingStars({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingStars(
      rating: rating,
      size: 18,
      showText: true,
    );
  }
}

// Large Gold Only (Review Section)
class LargeGoldRatingStars extends StatelessWidget {
  final double rating;
  const LargeGoldRatingStars({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingStars(
      rating: rating,
      size: 28,
      activeColor: AppColors.accent,
      inactiveColor: AppColors.accent.withOpacity(0.3),
      showText: true,
    );
  }
}