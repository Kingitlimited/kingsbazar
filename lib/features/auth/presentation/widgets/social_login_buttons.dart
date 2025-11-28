import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialLoginButtons extends StatelessWidget {
  final VoidCallback? onGoogle;
  final VoidCallback? onApple;
  final VoidCallback? onFacebook;

  const SocialLoginButtons({
    super.key,
    this.onGoogle,
    this.onApple,
    this.onFacebook,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _socialIcon("assets/icons/google.png", onGoogle),
        SizedBox(width: 20.w),
        _socialIcon("assets/icons/apple.png", onApple),
        SizedBox(width: 20.w),
        _socialIcon("assets/icons/facebook.png", onFacebook),
      ],
    );
  }

  Widget _socialIcon(String asset, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50.r),
      child: Container(
        width: 48.w,
        height: 48.w,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE53950)),
          borderRadius: BorderRadius.circular(50.r),
        ),
        padding: EdgeInsets.all(10.w),
        child: Image.asset(asset),
      ),
    );
  }
}
