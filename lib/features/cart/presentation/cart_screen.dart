// lib/features/cart/presentation/cart_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kingsbazar/core/utils/extensions.dart';
import 'package:kingsbazar/providers/cart_provider.dart';
import 'package:kingsbazar/core/constants/app_colors.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(title: Text('My Cart (${cartItems.length})')),
      body: cartItems.isEmpty
          ? Center(child: Text('Your cart is empty'))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (ctx, i) {
                final item = cartItems[i];
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.network(item.product.thumbnail, width: 60.w, height: 60.w, fit: BoxFit.cover),
                  ),
                  title: Text(item.product.title, maxLines: 1),
                  subtitle: Text('\$${item.product.price} × ${item.quantity}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => ref.read(cartProvider.notifier).decreaseQuantity(item.product.id),
                        icon: Icon(Icons.remove_circle_outline),
                      ),
                      Text(item.quantity.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                      IconButton(
                        onPressed: () => ref.read(cartProvider.notifier).increaseQuantity(item.product.id),
                        icon: Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.w),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total: \$${ref.watch(cartProvider.notifier).totalPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            ElevatedButton(
              onPressed: () {},
              child: Text('Checkout'),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}