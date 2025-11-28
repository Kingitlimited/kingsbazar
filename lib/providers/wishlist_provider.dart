/// lib/providers/wishlist_provider.dart
/// FULL — Starts EMPTY, persists

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:kingsbazar/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistNotifier extends StateNotifier<List<ProductModel>> {
  WishlistNotifier() : super([]) {
    _loadFromStorage();
  }

  static const String _key = 'wishlist';

  Future<void> _loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString != null) {
      final List<dynamic> list = json.decode(jsonString);
      state = list.map((json) => ProductModel.fromJson(json)).toList();
    }
  }

  Future<void> _saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(state.map((p) => p.toJson()).toList());
    await prefs.setString(_key, jsonString);
  }

  void toggle(ProductModel product) {
    if (state.any((p) => p.id == product.id)) {
      state = state.where((p) => p.id != product.id).toList();
    } else {
      state = [...state, product];
    }
    _saveToStorage();
  }

  bool isWishlisted(int productId) => state.any((p) => p.id == productId);
  int get count => state.length;
}

final wishlistProvider = StateNotifierProvider<WishlistNotifier, List<ProductModel>>((ref) {
  return WishlistNotifier();
});

final wishlistCountProvider = Provider<int>((ref) => ref.watch(wishlistProvider).length);
final isInWishlistProvider = Provider.family<bool, int>((ref, id) => ref.watch(wishlistProvider).any((p) => p.id == id));