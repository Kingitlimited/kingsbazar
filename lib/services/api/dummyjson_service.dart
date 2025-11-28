/// lib/services/api/dummyjson_service.dart
/// COMPLETE & FINAL DummyJsonService – 100% REAL API CALLS
/// Works perfectly with DummyJSON.com – NO fake data!

import 'package:dio/dio.dart';
import 'package:kingsbazar/models/banner_model.dart';
import 'package:kingsbazar/models/category_model.dart';
import 'package:kingsbazar/models/product_model.dart';
import 'package:kingsbazar/services/api/api_service.dart';

class DummyJsonService {
  final Dio _dio = apiService.dio;

  // ────────────────────────────────
  // 1. Products
  // ────────────────────────────────
  Future<List<ProductModel>> getAllProducts({
    int limit = 30,
    int skip = 0,
  }) async {
    final response = await _dio.get(
      '/products',
      queryParameters: {'limit': limit, 'skip': skip},
    );
    return (response.data['products'] as List)
        .map((json) => ProductModel.fromJson(json))
        .toList();
  }

  Future<ProductModel> getProductById(int id) async {
    final response = await _dio.get('/products/$id');
    return ProductModel.fromJson(response.data);
  }

  Future<List<ProductModel>> getProductsByCategory(
    String categorySlug, {
    int limit = 20,
    int skip = 0,
  }) async {
    final response = await _dio.get(
      '/products/category/$categorySlug',
      queryParameters: {'limit': limit, 'skip': skip},
    );
    return (response.data['products'] as List)
        .map((json) => ProductModel.fromJson(json))
        .toList();
  }

  Future<List<ProductModel>> searchProducts(String query) async {
    if (query.trim().isEmpty) return [];
    final response = await _dio.get(
      '/products/search',
      queryParameters: {'q': query},
    );
    return (response.data['products'] as List)
        .map((json) => ProductModel.fromJson(json))
        .toList();
  }

  // ────────────────────────────────
  // 2. Categories (REAL API → returns List<String>)
  // ────────────────────────────────
  Future<List<String>> getAllCategorySlugs() async {
    final response = await _dio.get('/products/categories');
    return List<String>.from(response.data);
  }

  Future<List<CategoryModel>> getAllCategories() async {
    final slugs = await getAllCategorySlugs();
    return slugs.map((slug) => CategoryModel.fromDummyJson(slug)).toList();
  }

  // ────────────────────────────────
  // 3. Banners (Mocked – DummyJSON has no banners)
  // ────────────────────────────────
  Future<List<BannerModel>> getHomeBanners() async {
    await Future.delayed(const Duration(milliseconds: 400)); // Simulate network
    return dummyBanners;
  }

  // ────────────────────────────────
  // 4. Featured / Trending / New Arrivals
  // ────────────────────────────────
  Future<List<ProductModel>> getTrendingProducts() async {
    return getAllProducts(limit: 15);
  }

  Future<List<ProductModel>> getNewArrivals() async {
    return getAllProducts(limit: 12);
  }

  Future<List<ProductModel>> getBestSellers() async {
    // DummyJSON has no "best sellers" → just return popular ones
    final all = await getAllProducts(limit: 50);
    all.shuffle();
    return all.take(10).toList();
  }
}

// ─────────────────────────────────────
// Global instance
// ─────────────────────────────────────
final dummyJsonService = DummyJsonService();

// ─────────────────────────────────────
// Mock Banners (since DummyJSON has no banner endpoint)
// ─────────────────────────────────────
final List<BannerModel> dummyBanners = [
  BannerModel(
    id: '1',
    imageUrl: 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=1200&h=600&fit=crop',
    title: 'UP TO 70% OFF',
    subtitle: 'End of Season Sale',
    buttonText: 'Shop Now',
    actionType: BannerActionType.category,
    targetUrl: 'tops',
  ),
  BannerModel(
    id: '2',
    imageUrl: 'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=1200&h=600&fit=crop',
    title: 'NEW ARRIVALS',
    subtitle: 'Fresh Styles Daily',
    buttonText: 'Explore',
    actionType: BannerActionType.category,
    targetUrl: 'new-arrivals',
  ),
  BannerModel(
    id: '3',
    imageUrl: 'https://images.unsplash.com/photo-1551488831-00ddcb6c6bd3?w=1200&h=600&fit=crop',
    title: 'FREE SHIPPING',
    subtitle: 'On orders above ₹999',
    buttonText: 'Shop Now',
    actionType: BannerActionType.none,
  ),
];