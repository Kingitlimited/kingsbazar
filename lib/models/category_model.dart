/// lib/models/category_model.dart
/// Complete Category model – 100% compatible with DummyJSON + extra features

class CategoryModel {
  final String slug;           // "smartphones", "laptops", "fragrances"
  final String name;           // "Smartphones", "Laptops", "Fragrances"
  final String? iconUrl;       // Optional icon (SVG/PNG)
  final String? bannerUrl;     // Optional banner for category page
  final int productCount;     // Number of products in this category
  final bool isFeatured;       // Show in home grid?

  const CategoryModel({
    required this.slug,
    required this.name,
    this.iconUrl,
    this.bannerUrl,
    this.productCount = 0,
    this.isFeatured = false,
  });

  // ────────────────────────────────
  // From DummyJSON (slug only)
  // ────────────────────────────────
  factory CategoryModel.fromDummyJson(String slug) {
    return CategoryModel(
      slug: slug,
      name: _formatName(slug),
      productCount: 0,
      isFeatured: _featuredSlugs.contains(slug),
    );
  }

  // ────────────────────────────────
  // Full JSON support (for custom backend later)
  // ────────────────────────────────
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      slug: json['slug'] as String,
      name: json['name'] as String? ?? _formatName(json['slug']),
      iconUrl: json['iconUrl'] as String?,
      bannerUrl: json['bannerUrl'] as String?,
      productCount: json['productCount'] as int? ?? 0,
      isFeatured: json['isFeatured'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'slug': slug,
        'name': name,
        'iconUrl': iconUrl,
        'bannerUrl': bannerUrl,
        'productCount': productCount,
        'isFeatured': isFeatured,
      };

  // ────────────────────────────────
  // Helpers
  // ────────────────────────────────
  static String _formatName(String slug) {
    return slug
        .split('-')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  // Featured categories for home screen grid
  static const List<String> _featuredSlugs = [
    'smartphones',
    'laptops',
    'fragrances',
    'skincare',
    'groceries',
    'home-decoration',
    'tops',
    'womens-dresses',
    'mens-shirts',
    'womens-shoes',
  ];

  // CopyWith
  CategoryModel copyWith({
    String? slug,
    String? name,
    String? iconUrl,
    String? bannerUrl,
    int? productCount,
    bool? isFeatured,
  }) {
    return CategoryModel(
      slug: slug ?? this.slug,
      name: name ?? this.name,
      iconUrl: iconUrl ?? this.iconUrl,
      bannerUrl: bannerUrl ?? this.bannerUrl,
      productCount: productCount ?? this.productCount,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }
}

// ──────────────────────────────────────────────────────
// ALL CATEGORIES FROM DUMMYJSON (ready to use)
// ──────────────────────────────────────────────────────
final List<CategoryModel> dummyCategories = [
  CategoryModel.fromDummyJson('smartphones'),
  CategoryModel.fromDummyJson('laptops'),
  CategoryModel.fromDummyJson('fragrances'),
  CategoryModel.fromDummyJson('skincare'),
  CategoryModel.fromDummyJson('groceries'),
  CategoryModel.fromDummyJson('home-decoration'),
  CategoryModel.fromDummyJson('furniture'),
  CategoryModel.fromDummyJson('tops'),
  CategoryModel.fromDummyJson('womens-dresses'),
  CategoryModel.fromDummyJson('womens-shoes'),
  CategoryModel.fromDummyJson('mens-shirts'),
  CategoryModel.fromDummyJson('mens-shoes'),
  CategoryModel.fromDummyJson('mens-watches'),
  CategoryModel.fromDummyJson('womens-watches'),
  CategoryModel.fromDummyJson('womens-bags'),
  CategoryModel.fromDummyJson('womens-jewellery'),
  CategoryModel.fromDummyJson('sunglasses'),
  CategoryModel.fromDummyJson('automotive'),
  CategoryModel.fromDummyJson('motorcycle'),
  CategoryModel.fromDummyJson('lighting'),
];

// Featured only (for home grid)
final List<CategoryModel> featuredCategories = dummyCategories
    .where((cat) => CategoryModel._featuredSlugs.contains(cat.slug))
    .toList();