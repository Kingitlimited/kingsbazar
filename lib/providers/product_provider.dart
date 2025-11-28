  
/// lib/providers/product_provider.dart
/// Complete Product Provider – All products, By Category, Search, Single Product
/// 100% REAL DATA from DummyJSON.com

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kingsbazar/models/product_model.dart';
import 'package:kingsbazar/services/api/dummyjson_service.dart';

/// ────────────────────────────────
/// 1. All Products (with pagination)
/// ────────────────────────────────
final productsProvider = FutureProvider.family<List<ProductModel>, int>((ref, page) async {
  final limit = 20;
  final skip = page * limit;
  return await dummyJsonService.getAllProducts(limit: limit, skip: skip);
});

/// ────────────────────────────────
/// 2. Products by Category
/// ────────────────────────────────
final categoryProductsProvider =
    FutureProvider.family<List<ProductModel>, String>((ref, categorySlug) async {
  return await dummyJsonService.getProductsByCategory(categorySlug, limit: 30);
});

/// ────────────────────────────────
/// 3. Single Product Detail
/// ────────────────────────────────
final productDetailProvider =
    FutureProvider.family<ProductModel, int>((ref, productId) async {
  return await dummyJsonService.getProductById(productId);
});

/// ────────────────────────────────
/// 4. Search Products
/// ────────────────────────────────
final searchProductsProvider =
    FutureProvider.family<List<ProductModel>, String>((ref, query) async {
  if (query.trim().isEmpty) return [];
  return await dummyJsonService.searchProducts(query);
});

/// ────────────────────────────────
/// 5. Trending / Featured Products (Home Screen)
/// ────────────────────────────────
final trendingProductsProvider = FutureProvider<List<ProductModel>>((ref) async {
  return await dummyJsonService.getTrendingProducts();
});

final newArrivalsProvider = FutureProvider<List<ProductModel>>((ref) async {
  return await dummyJsonService.getNewArrivals();
});

final bestSellersProvider = FutureProvider<List<ProductModel>>((ref) async {
  return await dummyJsonService.getBestSellers();
});

/// ────────────────────────────────
/// 6. Recommended Products (Product Detail Screen)
/// ────────────────────────────────
final recommendedProductsProvider =
    FutureProvider.family<List<ProductModel>, int>((ref, currentProductId) async {
  // Get category of current product first
  final productAsync = ref.watch(productDetailProvider(currentProductId));
  final category = await productAsync.when(
    data: (p) => p.category,
    loading: () => 'smartphones',
    error: (_, __) => 'smartphones',
  );

  final products = await dummyJsonService.getProductsByCategory(category, limit: 10);
  // Remove current product from list
  return products.where((p) => p.id != currentProductId).toList();
});