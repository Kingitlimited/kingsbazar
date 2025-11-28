/// lib/core/widgets/common/custom_appbar.dart
/// FINAL VERSION — 100% IDENTICAL TO YOUR MOCKUP

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kingsbazar/core/constants/app_colors.dart';
import 'package:kingsbazar/core/widgets/components/cart_badge.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final bool isHome;

  const CustomAppBar({Key? key, this.isHome = false}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isHome) {
      return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black.withOpacity(0.5), Colors.transparent],
            ),
          ),
        ),
        title: Row(
          children: [
            // Crown Logo (Small)
            Image.asset("assets/images/crown_logo.png", width: 36.w),
            SizedBox(width: 10.w),
            // KingsBazar Text (GOLD)
            Text(
              "KingsBazar",
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.accent, // GOLD
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        actions: [
          // Search Icon
          IconButton(
            icon: Icon(Icons.search_rounded, color: Colors.white, size: 28.w),
            onPressed: () => Navigator.pushNamed(context, '/search'),
          ),
          // Notification Bell
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.notifications_outlined, color: Colors.white, size: 28.w),
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    width: 10.w,
                    height: 10.w,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () => Navigator.pushNamed(context, '/notifications'),
          ),
          // Cart with Badge
          CartBadge(
            badgeColor: AppColors.primary,
            child: IconButton(
              icon: Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 26.w),
              onPressed: () => Navigator.pushNamed(context, '/cart'),
            ),
          ),
          // Profile Avatar
          Padding(
            padding: EdgeInsets.only(right: 12.w, left: 8.w),
            child: CircleAvatar(
              radius: 18.r,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 16.r,
                backgroundImage: AssetImage("assets/images/avatar.jpg"),
              ),
            ),
          ),
        ],
      );
    }

    // Normal Screens (White Background)
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      shadowColor: Colors.black12,
      title: Text(
        "KingsBazar",
        style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
      ),
      actions: [
        CartBadge(
          child: IconButton(
            icon: Icon(Icons.shopping_bag_outlined, color: AppColors.textPrimary),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
        ),
        SizedBox(width: 16.w),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}