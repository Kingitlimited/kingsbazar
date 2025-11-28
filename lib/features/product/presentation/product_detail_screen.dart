  
// lib/features/product/presentation/product_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:kingsbazar/core/constants/app_colors.dart';
import 'package:kingsbazar/core/utils/extensions.dart';
import 'package:kingsbazar/models/product_model.dart';
import 'package:kingsbazar/providers/cart_provider.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final ProductModel product;
  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  ConsumerState<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  int selectedImage = 0;
  String selectedSize = 'M';
  Color selectedColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final discount = product.discountPercentage.toInt();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Product Details'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.share)),
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
        ],
      ),
      body: Column(
        children: [
          // IMAGE CAROUSEL
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 350.h,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      onPageChanged: (i, _) => setState(() => selectedImage = i),
                    ),
                    items: product.images.map((url) => CachedNetworkImage(imageUrl: url, fit: BoxFit.contain)).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: product.images.asMap().entries.map((e) {
                      return Container(
                        width: 8.w,
                        height: 8.h,
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selectedImage == e.key ? AppColors.primary : Colors.grey,
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.title, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Text('\$${product.price}', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: AppColors.primary)),
                            SizedBox(width: 12.w),
                            if (discount > 0) ...[
                              Text('\$${product.oldPrice.toStringAsFixed(0)}', style: TextStyle(fontSize: 16.sp, decoration: TextDecoration.lineThrough, color: Colors.grey)),
                              SizedBox(width: 8.w),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(12.r)),
                                child: Text('$discount% OFF', style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                              ),
                            ],
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 20.sp),
                            SizedBox(width: 6.w),
                            Text(product.rating.toStringAsFixed(1), style: TextStyle(fontSize: 16.sp)),
                            Text(' (${product.stock} in stock)', style: TextStyle(color: Colors.green)),
                          ],
                        ),
                        SizedBox(height: 20.h),

                        Text('Select Size', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                        SizedBox(height: 8.h),
                        Row(
                          children: ['S', 'M', 'L', 'XL'].map((size) {
                            return GestureDetector(
                              onTap: () => setState(() => selectedSize = size),
                              child: Container(
                                margin: EdgeInsets.only(right: 12.w),
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  border: Border.all(color: selectedSize == size ? AppColors.primary : Colors.grey),
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: selectedSize == size ? AppColors.primary.withOpacity(0.1) : null,
                                ),
                                child: Text(size, style: TextStyle(fontSize: 14.sp)),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 20.h),

                        Text('Description', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                        SizedBox(height: 8.h),
                        Text(product.description, style: TextStyle(fontSize: 14.sp, color: Colors.grey[700], height: 1.5)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // BOTTOM ADD TO CART BAR
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text('BUY NOW', style: TextStyle(fontSize: 16.sp)),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.primary, width: 2),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(cartProvider.notifier).addToCart(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Added to cart!'), backgroundColor: AppColors.primary),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                    ),
                    child: Text('ADD TO CART', style: TextStyle(fontSize: 16.sp)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}