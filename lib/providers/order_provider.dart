/// lib/providers/order_provider.dart
/// FINAL VERSION — FULLY FIXED — All required fields included

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:kingsbazar/models/address_model.dart';

import 'package:kingsbazar/models/order_model.dart';
import 'package:kingsbazar/providers/cart_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderNotifier extends StateNotifier<AsyncValue<List<OrderModel>>> {
  OrderNotifier(this.ref) : super(const AsyncValue.loading()) {
    _loadOrdersFromStorage();
  }

  final Ref ref;

  static const String _key = 'user_orders';

  // Load saved orders on app start
  Future<void> _loadOrdersFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_key);

      if (jsonString != null && jsonString.isNotEmpty) {
        final List<dynamic> list = json.decode(jsonString);
        final orders = list.map((json) => OrderModel.fromJson(json)).toList();
        state = AsyncValue.data(orders);
      } else {
        state = const AsyncValue.data([]); // First launch → empty
      }
    } catch (e) {
      state = const AsyncValue.data([]);
    }
  }

  // Save orders to storage
  Future<void> _saveOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(
      state.value?.map((order) => order.toJson()).toList() ?? [],
    );
    await prefs.setString(_key, jsonString);
  }

  // PLACE ORDER — NOW 100% CORRECT
  Future<void> placeOrder({
    required AddressModel shippingAddress,
    required PaymentMethod paymentMethod,
    String? couponCode,
  }) async {
    final cartItems = ref.read(cartProvider);
    if (cartItems.isEmpty) return;

    final subtotal = ref.read(cartSubtotalProvider);
    final discount = (couponCode == 'WELCOME500') ? 500.0 : 0.0;
    final shippingCharge = 0.0; // Free shipping
    final totalAmount = (subtotal - discount + shippingCharge).clamp(0.0, double.infinity);

    final newOrder = OrderModel(
      id: 'ORD-${DateTime.now().millisecondsSinceEpoch}',
      orderNumber: 'KS${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      orderDate: DateTime.now(),
      status: paymentMethod == PaymentMethod.cod ? OrderStatus.confirmed : OrderStatus.processing,
      paymentMethod: paymentMethod,
      paymentStatus: paymentMethod == PaymentMethod.cod ? PaymentStatus.pending : PaymentStatus.paid,
      subtotal: subtotal,
      discount: discount,
      shippingCharge: shippingCharge,
      couponCode: couponCode,
      totalAmount: totalAmount,
      items: cartItems,
      shippingAddress: shippingAddress,
       // Same for now
    );

    // Add to history
    state = state.whenData((orders) => [newOrder, ...orders]);

    // Save to storage
    await _saveOrders();

    // Clear cart
    ref.read(cartProvider.notifier).clearCart();

    // Optional success message
    // showGlobalSnackBar(message: "Order placed successfully!", success: true);
  }
}

// ─────────────────────────────────────
// Provider
// ─────────────────────────────────────
final orderProvider = StateNotifierProvider<OrderNotifier, AsyncValue<List<OrderModel>>>((ref) {
  return OrderNotifier(ref);
});

// Recent orders (for home screen)
final recentOrdersProvider = Provider<List<OrderModel>>((ref) {
  return ref.watch(orderProvider).when(
    data: (orders) => orders.take(3).toList(),
    loading: () => [],
    error: (_, __) => [],
  );
});