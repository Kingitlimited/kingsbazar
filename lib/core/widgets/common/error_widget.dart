  
/// lib/core/widgets/common/error_widget.dart
/// Beautiful, reusable error states – network error, server error, etc.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kingsbazar/core/constants/app_colors.dart';
import 'package:kingsbazar/core/widgets/common/custom_button.dart';
import 'package:lottie/lottie.dart';

class CustomErrorWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback? onRetry;
  final String? lottieAsset;
  final double? imageHeight;

  const CustomErrorWidget({
    Key? key,
    this.title = 'Oops! Something went wrong',
    this.subtitle = 'We are having trouble connecting. Please check your internet connection and try again.',
    this.buttonText = 'Try Again',
    this.onRetry,
    this.lottieAsset,
    this.imageHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animation / Illustration
            lottieAsset != null
                ? Lottie.asset(
                    lottieAsset!,
                    height: imageHeight ?? 220.h,
                    fit: BoxFit.contain,
                    repeat: true,
                  )
                : _defaultErrorIllustration(),

            SizedBox(height: 32.h),

            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            SizedBox(height: 16.h),

            // Subtitle
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.sp,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),

            SizedBox(height: 40.h),

            // Retry Button
            if (onRetry != null)
              PrimaryButton(
                label: buttonText,
                onPressed: onRetry!,
              ),
          ],
        ),
      ),
    );
  }

  Widget _defaultErrorIllustration() {
    return Container(
      height: imageHeight ?? 220.h,
      width: 220.w,
      decoration: BoxDecoration(
        color: AppColors.error.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.error_outline,
        size: 90.sp,
        color: AppColors.error,
      ),
    );
  }
}

// ──────────────────────────────────────────────────────
// PRE-BUILT ERROR WIDGETS (use directly)
// ──────────────────────────────────────────────────────

/// Generic Network/Server Error
class NetworkErrorWidget extends StatelessWidget {
  final VoidCallback? onRetry;
  const NetworkErrorWidget({Key? key, this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomErrorWidget(
      title: 'No Internet Connection',
      subtitle: 'Please check your internet connection and try again.',
      buttonText: 'Retry',
      lottieAsset: 'assets/lottie/no_internet.json', // optional
      onRetry: onRetry,
    );
  }
}

/// Server Error (500, timeout, etc.)
class ServerErrorWidget extends StatelessWidget {
  final VoidCallback? onRetry;
  const ServerErrorWidget({Key? key, this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomErrorWidget(
      title: 'Server Error',
      subtitle: 'We\'re experiencing technical issues. Our team is working on it.',
      buttonText: 'Try Again',
      lottieAsset: 'assets/lottie/server_error.json',
      onRetry: onRetry,
    );
  }
}

/// Generic Something Went Wrong
class GenericErrorWidget extends StatelessWidget {
  final VoidCallback? onRetry;
  const GenericErrorWidget({Key? key, this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomErrorWidget(
      title: 'Something Went Wrong',
      subtitle: 'An unexpected error occurred. Please try again.',
      onRetry: onRetry,
    );
  }
}