/// lib/providers/cart_provider.dart
/// FULL — Starts EMPTY, persists with SharedPreferences

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:kingsbazar/models/cart_item_model.dart';
import 'package:kingsbazar/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartNotifier extends StateNotifier<List<CartItemModel>> {
  CartNotifier() : super([]) {
    _loadFromStorage();
  }

  static const String _key = 'cart_items';

  Future<void> _loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      state = jsonList.map((json) => CartItemModel.fromJson(json)).toList();
    }
  }

  Future<void> _saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(state.map((e) => e.toJson()).toList());
    await prefs.setString(_key, jsonString);
  }

  void addItem(ProductModel product, {String? size, String? color}) {
    final existingIndex = state.indexWhere(
      (item) => item.product.id == product.id && item.selectedSize == size && item.selectedColor == color,
    );

    if (existingIndex >= 0) {
      state[existingIndex].quantity++;
    } else {
      state = [...state, CartItemModel(product: product, quantity: 1, selectedSize: size, selectedColor: color)];
    }
    _saveToStorage();
  }

  void removeItem(CartItemModel item) {
    state = state.where((i) => i != item).toList();
    _saveToStorage();
  }

  void updateQuantity(CartItemModel item, int quantity) {
    if (quantity <= 0) {
      removeItem(item);
      return;
    }
    state = state.map((i) => i == item ? i.copyWith(quantity: quantity) : i).toList();
    _saveToStorage();
  }

  void clearCart() {
    state = [];
    _saveToStorage();
  }

  double get subtotal => state.fold(0.0, (sum, item) => sum + item.totalPrice);
  int get itemCount => state.fold(0, (sum, item) => sum + item.quantity);
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItemModel>>((ref) {
  return CartNotifier();
});

final cartItemCountProvider = Provider<int>((ref) => ref.watch(cartProvider).fold(0, (sum, item) => sum + item.quantity));
final cartSubtotalProvider = Provider<double>((ref) => ref.watch(cartProvider).fold(0.0, (sum, item) => sum + item.totalPrice));