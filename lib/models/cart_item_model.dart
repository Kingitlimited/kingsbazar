/// lib/models/cart_item_model.dart
/// Fully fixed – no more 'toJson not defined' error

import 'package:kingsbazar/models/product_model.dart';

class CartItemModel {
  final ProductModel product;
  int quantity;
  String? selectedSize;
  String? selectedColor;

  CartItemModel({
    required this.product,
    this.quantity = 1,
    this.selectedSize,
    this.selectedColor,
  });

  // ────────────────────────────────
  // Calculated values
  // ────────────────────────────────
  double get totalPrice => product.price * quantity;
  double get totalOldPrice => product.oldPrice * quantity;
  double get totalDiscount => totalOldPrice - totalPrice;

  String get priceDisplay => '\$${totalPrice.toStringAsFixed(2)}';

  // ────────────────────────────────
  // JSON Serialization
  // ────────────────────────────────
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int? ?? 1,
      selectedSize: json['selectedSize'] as String?,
      selectedColor: json['selectedColor'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'product': product.toJson(),        // Now works – we added toJson() in ProductModel
        'quantity': quantity,
        'selectedSize': selectedSize,
        'selectedColor': selectedColor,
      };

  // ────────────────────────────────
  // copyWith
  // ────────────────────────────────
  CartItemModel copyWith({
    ProductModel? product,
    int? quantity,
    String? selectedSize,
    String? selectedColor,
  }) {
    return CartItemModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemModel &&
          runtimeType == other.runtimeType &&
          product.id == other.product.id &&
          selectedSize == other.selectedSize &&
          selectedColor == other.selectedColor;

  @override
  int get hashCode => Object.hash(product.id, selectedSize, selectedColor);
}