/// lib/models/banner_model.dart
/// Banner model – used in Home Screen slider & promotional sections

class BannerModel {
  final String id;
  final String imageUrl;
  final String? title;
  final String? subtitle;
  final String? buttonText;
  final String? targetUrl;        // Deep link or product/category ID
  final BannerActionType actionType;
  final bool isActive;

  const BannerModel({
    required this.id,
    required this.imageUrl,
    this.title,
    this.subtitle,
    this.buttonText,
    this.targetUrl,
    this.actionType = BannerActionType.none,
    this.isActive = true,
  });

  // JSON → Model
  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'].toString(),
      imageUrl: json['imageUrl'] ?? json['image'] ?? '',
      title: json['title'],
      subtitle: json['subtitle'],
      buttonText: json['buttonText'],
      targetUrl: json['targetUrl'],
      actionType: _parseActionType(json['actionType']),
      isActive: json['isActive'] ?? true,
    );
  }

  // Model → JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'imageUrl': imageUrl,
        'title': title,
        'subtitle': subtitle,
        'buttonText': buttonText,
        'targetUrl': targetUrl,
        'actionType': actionType.name,
        'isActive': isActive,
      };

  // CopyWith
  BannerModel copyWith({
    String? id,
    String? imageUrl,
    String? title,
    String? subtitle,
    String? buttonText,
    String? targetUrl,
    BannerActionType? actionType,
    bool? isActive,
  }) {
    return BannerModel(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      buttonText: buttonText ?? this.buttonText,
      targetUrl: targetUrl ?? this.targetUrl,
      actionType: actionType ?? this.actionType,
      isActive: isActive ?? this.isActive,
    );
  }

  static BannerActionType _parseActionType(String? type) {
    switch (type?.toLowerCase()) {
      case 'product':
        return BannerActionType.product;
      case 'category':
        return BannerActionType.category;
      case 'url':
        return BannerActionType.url;
      case 'none':
      default:
        return BannerActionType.none;
    }
  }
}

enum BannerActionType {
  none,
  product,    // → Navigate to Product Detail
  category,   // → Navigate to Category Screen
  url,        // → Open external link
}

// ──────────────────────────────────────────────────────
// SAMPLE BANNERS (for testing without backend)
// ──────────────────────────────────────────────────────
final List<BannerModel> dummyBanners = [
  BannerModel(
    id: '1',
    imageUrl: 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=1200&h=600&fit=crop',
    title: 'UP TO 70% OFF',
    subtitle: 'End of Season Sale',
    buttonText: 'Shop Now',
    actionType: BannerActionType.category,
    targetUrl: 'sale',
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
    subtitle: 'On orders above \$50',
    buttonText: 'Shop Now',
    actionType: BannerActionType.none,
  ),
];