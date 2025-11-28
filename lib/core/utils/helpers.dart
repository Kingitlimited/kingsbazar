  
/// lib/core/utils/helpers.dart
/// Collection of reusable helper functions used throughout the app

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kingsbazar/core/constants/app_colors.dart';

class Helpers {
  // Prevent instantiation
  Helpers._();

  /// Show a beautiful snackbar
  static void showSnackBar({
    required BuildContext context,
    required String message,
    bool success = true,
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? AppColors.primary : AppColors.error,
        behavior: SnackBarBehavior.floating,
        duration: duration,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(16),
      ),
    );
  }

  /// Format price with currency symbol
  static String formatPrice(double price) {
    final formatter = NumberFormat.currency(
      symbol: '\$',
      decimalDigits: 2,
    );
    return formatter.format(price);
  }

  /// Format date
  static String formatDate(DateTime date, {String pattern = 'dd MMM yyyy'}) {
    return DateFormat(pattern).format(date);
  }

  /// Capitalize first letter of each word
  static String toTitleCase(String text) {
    if (text.isEmpty) return text;
    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  /// Generate rating stars widget
  static Widget buildRatingStars(double rating, {double size = 16}) {
    return Row(
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return Icon(Icons.star, color: Colors.amber, size: size);
        } else if (index < rating) {
          return Icon(Icons.star_half, color: Colors.amber, size: size);
        } else {
          return Icon(Icons.star_border, color: Colors.amber, size: size);
        }
      }),
    );
  }

  /// Check if string is valid email
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  /// Check if string is valid phone (10 digits)
  static bool isValidPhone(String phone) {
    return RegExp(r'^\d{10}$').hasMatch(phone.replaceAll(RegExp(r'\D'), ''));
  }

  /// Truncate text with ellipsis
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  /// Launch URL (add url_launcher later if needed)
  // static Future<void> launchURL(String url) async {
  //   if (await canLaunchUrl(Uri.parse(url))) {
  //     await launchUrl(Uri.parse(url));
  //   }
  // }

  /// Generate placeholder image URL (for testing)
  static String placeholderImage({int width = 400, int height = 600}) {
    return 'https://via.placeholder.com/${width}x$height/EEEEEE/E30425?text=No+Image';
  }

  /// Get discount percentage text
  static String getDiscountText(double original, double discounted) {
    if (original <= discounted) return '';
    final discount = ((original - discounted) / original * 100).round();
    return '$discount% OFF';
  }

  /// Hide keyboard
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}