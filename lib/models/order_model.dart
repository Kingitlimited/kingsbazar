  
/// lib/models/order_model.dart
/// Complete Order model – used in My Orders, Order Tracking, Order Success

import 'package:flutter/material.dart';
import 'package:kingsbazar/models/address_model.dart';
import 'package:kingsbazar/models/cart_item_model.dart';

class OrderModel {
  final String id;                          // "ORD-2025-0001"
  final String orderNumber;                 // "20250001"
  final DateTime orderDate;
  final DateTime? deliveredDate;
  final OrderStatus status;
  final PaymentMethod paymentMethod;
  final PaymentStatus paymentStatus;
  final double subtotal;
  final double discount;
  final double shippingCharge;
  final double tax;
  final double totalAmount;
  final List<CartItemModel> items;
  final AddressModel shippingAddress;
  final String? couponCode;
  final String? transactionId;
  final String? trackingNumber;
  final String? notes;

  const OrderModel({
    required this.id,
    required this.orderNumber,
    required this.orderDate,
    this.deliveredDate,
    this.status = OrderStatus.processing,
    this.paymentMethod = PaymentMethod.cod,
    this.paymentStatus = PaymentStatus.pending,
    required this.subtotal,
    this.discount = 0.0,
    this.shippingCharge = 0.0,
    this.tax = 0.0,
    required this.totalAmount,
    required this.items,
    required this.shippingAddress,
    this.couponCode,
    this.transactionId,
    this.trackingNumber,
    this.notes,
  });

  // ────────────────────────────────
  // JSON
  // ────────────────────────────────
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      orderNumber: json['orderNumber'] as String,
      orderDate: DateTime.parse(json['orderDate'] as String),
      deliveredDate: json['deliveredDate'] != null
          ? DateTime.parse(json['deliveredDate'] as String)
          : null,
      status: _parseStatus(json['status'] as String?),
      paymentMethod: _parsePaymentMethod(json['paymentMethod'] as String?),
      paymentStatus: _parsePaymentStatus(json['paymentStatus'] as String?),
      subtotal: (json['subtotal'] as num).toDouble(),
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      shippingCharge: (json['shippingCharge'] as num?)?.toDouble() ?? 0.0,
      tax: (json['tax'] as num?)?.toDouble() ?? 0.0,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      items: (json['items'] as List)
          .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      shippingAddress: AddressModel.fromJson(json['shippingAddress'] as Map<String, dynamic>),
      couponCode: json['couponCode'] as String?,
      transactionId: json['transactionId'] as String?,
      trackingNumber: json['trackingNumber'] as String?,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'orderNumber': orderNumber,
        'orderDate': orderDate.toIso8601String(),
        'deliveredDate': deliveredDate?.toIso8601String(),
        'status': status.name,
        'paymentMethod': paymentMethod.name,
        'paymentStatus': paymentStatus.name,
        'subtotal': subtotal,
        'discount': discount,
        'shippingCharge': shippingCharge,
        'tax': tax,
        'totalAmount': totalAmount,
        'items': items.map((e) => e.toJson()).toList(),
        'shippingAddress': shippingAddress.toJson(),
        'couponCode': couponCode,
        'transactionId': transactionId,
        'trackingNumber': trackingNumber,
        'notes': notes,
      };

  // ────────────────────────────────
  // Helpers
  // ────────────────────────────────
  String get statusText => switch (status) {
        OrderStatus.pending => 'Pending',
        OrderStatus.confirmed => 'Confirmed',
        OrderStatus.processing => 'Processing',
        OrderStatus.shipped => 'Shipped',
        OrderStatus.outForDelivery => 'Out for Delivery',
        OrderStatus.delivered => 'Delivered',
        OrderStatus.cancelled => 'Cancelled',
        OrderStatus.returned => 'Returned',
        OrderStatus.failed => 'Failed',
      };

  Color get statusColor => switch (status) {
        OrderStatus.pending => Colors.orange,
        OrderStatus.confirmed || OrderStatus.processing => Colors.blue,
        OrderStatus.shipped || OrderStatus.outForDelivery => Colors.purple,
        OrderStatus.delivered => Colors.green,
        OrderStatus.cancelled || OrderStatus.failed => Colors.red,
        OrderStatus.returned => Colors.grey,
      };

  // CopyWith
  OrderModel copyWith({
    String? id,
    String? orderNumber,
    DateTime? orderDate,
    DateTime? deliveredDate,
    OrderStatus? status,
    PaymentMethod? paymentMethod,
    PaymentStatus? paymentStatus,
    double? subtotal,
    double? discount,
    double? shippingCharge,
    double? tax,
    double? totalAmount,
    List<CartItemModel>? items,
    AddressModel? shippingAddress,
    String? couponCode,
    String? transactionId,
    String? trackingNumber,
    String? notes,
  }) {
    return OrderModel(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      orderDate: orderDate ?? this.orderDate,
      deliveredDate: deliveredDate ?? this.deliveredDate,
      status: status ?? this.status,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      subtotal: subtotal ?? this.subtotal,
      discount: discount ?? this.discount,
      shippingCharge: shippingCharge ?? this.shippingCharge,
      tax: tax ?? this.tax,
      totalAmount: totalAmount ?? this.totalAmount,
      items: items ?? this.items,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      couponCode: couponCode ?? this.couponCode,
      transactionId: transactionId ?? this.transactionId,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      notes: notes ?? this.notes,
    );
  }
}

// ─────────────────────────────────────
// Enums
// ─────────────────────────────────────
enum OrderStatus {
  pending,
  confirmed,
  processing,
  shipped,
  outForDelivery,
  delivered,
  cancelled,
  returned,
  failed,
}

enum PaymentMethod {
  cod,
  razorpay,
  stripe,
  paypal,
  wallet,
}

enum PaymentStatus {
  pending,
  paid,
  failed,
  refunded,
}

// ─────────────────────────────────────
// Parse Helpers
// ─────────────────────────────────────
OrderStatus _parseStatus(String? status) =>
    OrderStatus.values.firstWhere((e) => e.name == status, orElse: () => OrderStatus.pending);

PaymentMethod _parsePaymentMethod(String? method) =>
    PaymentMethod.values.firstWhere((e) => e.name == method, orElse: () => PaymentMethod.cod);

PaymentStatus _parsePaymentStatus(String? status) =>
    PaymentStatus.values.firstWhere((e) => e.name == status, orElse: () => PaymentStatus.pending);