 
/// lib/core/widgets/components/payment_method_card.dart
/// Beautiful Payment Method Card – Used in Checkout Screen
/// Matches your red-gold design perfectly

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kingsbazar/core/constants/app_colors.dart';

enum PaymentMethodType {
  cod,
  upi,
  card,
  netbanking,
  wallet,
  razorpay,
}

class PaymentMethodCard extends StatelessWidget {
  final PaymentMethodType type;
  final String title;
  final String? subtitle;
  final String iconAsset;
  final bool isSelected;
  final VoidCallback onTap;
  final bool showRadio; // true = radio button, false = checkmark

  const PaymentMethodCard({
    Key? key,
    required this.type,
    required this.title,
    this.subtitle,
    required this.iconAsset,
    required this.isSelected,
    required this.onTap,
    this.showRadio = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade200,
            width: isSelected ? 2.5 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? AppColors.primary.withOpacity(0.18)
                  : Colors.black.withOpacity(0.06),
              blurRadius: isSelected ? 16 : 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon (SVG or PNG)
            Container(
              width: 52.w,
              height: 52.w,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withOpacity(0.1)
                    : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: iconAsset.endsWith('.svg')
                  ? SvgPicture.asset(
                      iconAsset,
                      colorFilter: ColorFilter.mode(
                        isSelected ? AppColors.primary : Colors.grey.shade600,
                        BlendMode.srcIn,
                      ),
                    )
                  : Image.asset(iconAsset, color: isSelected ? AppColors.primary : null),
            ),

            SizedBox(width: 16.w),

            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Selection Indicator
            if (showRadio)
              Radio<PaymentMethodType>(
                value: type,
                groupValue: isSelected ? type : null,
                onChanged: (_) => onTap(),
                activeColor: AppColors.primary,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              )
            else
              AnimatedOpacity(
                opacity: isSelected ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.primary,
                  size: 28.w,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────
// QUICK PRESET PAYMENT CARDS (Use in Checkout)
// ─────────────────────────────────────
class PaymentMethodsList extends StatelessWidget {
  final PaymentMethodType selectedMethod;
  final Function(PaymentMethodType) onMethodSelected;

  const PaymentMethodsList({
    Key? key,
    required this.selectedMethod,
    required this.onMethodSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PaymentMethodCard(
          type: PaymentMethodType.cod,
          title: "Cash on Delivery",
          subtitle: "Pay when you receive",
          iconAsset: "assets/icons/cod.svg",
          isSelected: selectedMethod == PaymentMethodType.cod,
          onTap: () => onMethodSelected(PaymentMethodType.cod),
        ),
        PaymentMethodCard(
          type: PaymentMethodType.upi,
          title: "UPI",
          subtitle: "Google Pay, PhonePe, BHIM etc.",
          iconAsset: "assets/icons/upi.svg",
          isSelected: selectedMethod == PaymentMethodType.upi,
          onTap: () => onMethodSelected(PaymentMethodType.upi),
        ),
        PaymentMethodCard(
          type: PaymentMethodType.card,
          title: "Credit / Debit Card",
          subtitle: "Visa, MasterCard, RuPay",
          iconAsset: "assets/icons/card.svg",
          isSelected: selectedMethod == PaymentMethodType.card,
          onTap: () => onMethodSelected(PaymentMethodType.card),
        ),
        PaymentMethodCard(
          type: PaymentMethodType.razorpay,
          title: "Pay with Razorpay",
          subtitle: "All payment methods in one",
          iconAsset: "assets/icons/razorpay.svg",
          isSelected: selectedMethod == PaymentMethodType.razorpay,
          onTap: () => onMethodSelected(PaymentMethodType.razorpay),
        ),
      ],
    );
  }
}