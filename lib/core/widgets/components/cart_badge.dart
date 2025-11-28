  
/// lib/core/widgets/components/cart_badge.dart
/// Smart Cart Badge with Animation – Works with Bottom Nav, AppBar, FAB, etc.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kingsbazar/core/constants/app_colors.dart';
import 'package:kingsbazar/providers/cart_provider.dart';

class CartBadge extends ConsumerWidget {
  final Widget child;
  final Color badgeColor;
  final Color textColor;
  final double badgeSize;
  final bool showZero;

  const CartBadge({
    Key? key,
    required this.child,
    this.badgeColor = AppColors.primary,
    this.textColor = Colors.white,
    this.badgeSize = 20.0,
    this.showZero = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartCount = ref.watch(cartItemCountProvider);

    // Don't show badge if count is 0 and showZero is false
    if (cartCount == 0 && !showZero) {
      return child;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,

        // Animated Badge
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.elasticOut,
          top: -4,
          right: -10,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            constraints: BoxConstraints(
              minWidth: badgeSize,
              minHeight: badgeSize,
            ),
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(badgeSize),
              boxShadow: [
                BoxShadow(
                  color: badgeColor.withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                cartCount > 99 ? "99+" : cartCount.toString(),
                style: TextStyle(
                  color: textColor,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────
// QUICK USAGE WIDGETS (Most Used)
// ─────────────────────────────────────

// For Bottom Navigation Bar
class CartNavIcon extends StatelessWidget {
  const CartNavIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CartBadge(
      child: Icon(
        Icons.shopping_bag_outlined,
        size: 28.w,
      ),
    );
  }
}

// For AppBar (with notification style)
class CartAppBarIcon extends StatelessWidget {
  const CartAppBarIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CartBadge(
      badgeColor: Colors.red,
      badgeSize: 22,
      child: Icon(
        Icons.shopping_cart_outlined,
        size: 26.w,
        color: Colors.black87,
      ),
    );
  }
}

// For Floating Action Button (FAB)
class CartFAB extends StatelessWidget {
  final VoidCallback onPressed;

  const CartFAB({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CartBadge(
      badgeColor: AppColors.primary,
      badgeSize: 26,
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: AppColors.primary,
        elevation: 6,
        child: Icon(Icons.shopping_cart, size: 28.w, color: Colors.white),
      ),
    );
  }
}