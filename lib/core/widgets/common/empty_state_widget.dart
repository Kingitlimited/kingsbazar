  
/// lib/core/widgets/common/empty_state_widget.dart
/// Beautiful empty states used across the app (Cart, Wishlist, Orders, Search, etc.)

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kingsbazar/core/constants/app_colors.dart';
import 'package:kingsbazar/core/widgets/common/custom_button.dart';
import 'package:lottie/lottie.dart';

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback? onButtonPressed;
  final String? lottieAsset;           // Optional custom animation
  final double? imageHeight;

  const EmptyStateWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    this.buttonText = 'Shop Now',
    this.onButtonPressed,
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
            // Lottie Animation or Default Illustration
            lottieAsset != null
                ? Lottie.asset(
                    lottieAsset!,
                    height: imageHeight ?? 240.h,
                    fit: BoxFit.contain,
                  )
                : _defaultIllustration(),

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

            SizedBox(height: 12.h),

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

            SizedBox(height: 32.h),

            // Action Button
            if (onButtonPressed != null)
              PrimaryButton(
                label: buttonText,
                onPressed: onButtonPressed!,
              ),
          ],
        ),
      ),
    );
  }

  Widget _defaultIllustration() {
    // You can replace this with your own SVG/PNG later
    return Container(
      height: imageHeight ?? 240.h,
      width: 240.w,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.08),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.shopping_bag_outlined,
        size: 100.sp,
        color: AppColors.primary.withOpacity(0.6),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────
// PRE-BUILT EMPTY STATES (use directly)
// ──────────────────────────────────────────────────────

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      title: 'Your cart is empty',
      subtitle: 'Looks like you haven\'t added anything to your cart yet',
      buttonText: 'Start Shopping',
      lottieAsset: 'assets/lottie/empty_cart.json', // add this file later
      onButtonPressed: () => context.go('/home'),
    );
  }
}

class EmptyWishlistWidget extends StatelessWidget {
  const EmptyWishlistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      title: 'Your wishlist is empty',
      subtitle: 'Save your favorite items and find them here',
      buttonText: 'Browse Products',
      lottieAsset: 'assets/lottie/empty_wishlist.json',
      onButtonPressed: () => context.go('/home'),
    );
  }
}

class EmptyOrdersWidget extends StatelessWidget {
  const EmptyOrdersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      title: 'No orders yet',
      subtitle: 'Place your first order and track it here',
      buttonText: 'Shop Now',
      onButtonPressed: () => context.go('/home'),
    );
  }
}

class EmptySearchWidget extends StatelessWidget {
  const EmptySearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      title: 'No results found',
      subtitle: 'Try searching with different keywords',
      lottieAsset: 'assets/lottie/no_search.json',
      onButtonPressed: null, // No button
    );
  }
}