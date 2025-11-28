 
/// lib/providers/app_state_provider.dart
/// Global App State – Cart count, Wishlist count, Auth state, Theme, etc.
/// The HEART of your KingsBazar app – used everywhere!

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:kingsbazar/models/address_model.dart';
import 'package:kingsbazar/models/user_model.dart';

/// ──────────────────────────────────────
/// 1. Current User (Guest or Logged-in)
/// ──────────────────────────────────────
final currentUserProvider = StateProvider<UserModel>((ref) {
  // Start as guest – change on login
  return guestUser;
});

/// ──────────────────────────────────────
/// 2. Cart Item Count (for badge)
/// ──────────────────────────────────────
final cartItemCountProvider = Provider<int>((ref) {
  // You'll connect this to cartProvider later
  // For now: return dummy count or real when ready
  return 3; // Remove when cartProvider is ready
});

/// ──────────────────────────────────────
/// 3. Wishlist Item Count (for badge)
/// ──────────────────────────────────────
final wishlistItemCountProvider = Provider<int>((ref) {
  return 7; // Replace with real wishlist provider later
});

/// ──────────────────────────────────────
/// 4. App Theme Mode (Light/Dark)
/// ──────────────────────────────────────
final themeModeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.light;
});

/// ──────────────────────────────────────
/// 5. Bottom Navigation Index (for MainScreen)
/// ──────────────────────────────────────
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

/// ──────────────────────────────────────
/// 6. App Loading State (global overlay)
/// ──────────────────────────────────────
final isAppLoadingProvider = StateProvider<bool>((ref) => false);

/// ──────────────────────────────────────
/// 7. Network Connectivity Status
/// ──────────────────────────────────────
final isOnlineProvider = StateProvider<bool>((ref) => true);

/// ──────────────────────────────────────
/// 8. Selected Address for Checkout
/// ──────────────────────────────────────
final selectedAddressForCheckoutProvider = StateProvider<AddressModel?>((ref) => null);

/// ──────────────────────────────────────
/// 9. Global Scaffold Key (for SnackBars from anywhere)
/// ──────────────────────────────────────
final globalScaffoldKey = GlobalKey<ScaffoldMessengerState>();

/// ──────────────────────────────────────
/// 10. Helper: Show Global SnackBar
/// ──────────────────────────────────────
void showGlobalSnackBar({
  required String message,
  bool success = true,
  Duration duration = const Duration(seconds: 3),
}) {
  final scaffold = globalScaffoldKey.currentState;
  if (scaffold != null) {
    scaffold.hideCurrentSnackBar();
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
        duration: duration,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}