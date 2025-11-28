// lib/features/home/presentation/home_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart'; // ← ADD THIS
import 'package:kingsbazar/core/widgets/components/banner_slider.dart';
import 'package:kingsbazar/core/widgets/components/section_title.dart';
import 'package:kingsbazar/core/widgets/components/category_circle.dart';
import 'package:kingsbazar/core/widgets/components/product_card.dart';
import 'package:kingsbazar/core/widgets/components/deal_of_day_card.dart';
import 'package:kingsbazar/features/product/presentation/product_detail_screen.dart';
import 'package:kingsbazar/services/api/dummyjson_service.dart';
import 'package:kingsbazar/models/banner_model.dart';
import 'package:kingsbazar/models/category_model.dart';
import 'package:kingsbazar/models/product_model.dart';
import 'package:kingsbazar/core/constants/app_colors.dart';
import 'package:kingsbazar/core/utils/extensions.dart';

class HomeScreen extends ConsumerWidget {
  // ← CHANGE TO ConsumerWidget
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ← ADD ref
    return Scaffold(
      backgroundColor: AppColors.background,
      body: FutureBuilder<List<dynamic>>(
        future: Future.wait([
          rootBundle
              .loadString('assets/json/banners.json')
              .then(
                (str) =>
                    (json.decode(str) as List)
                        .map((e) => BannerModel.fromJson(e))
                        .toList(),
              ),
          DummyJsonService.getCategories(),
          DummyJsonService.getTrendingProducts(),
          DummyJsonService.getDealOfTheDay(),
        ]),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          final List<BannerModel> banners = snapshot.data![0];
          final List<CategoryModel> categories = snapshot.data![1];
          final List<ProductModel> trending = snapshot.data![2];
          final ProductModel deal = snapshot.data![3];

          return SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 20.h),
            child: Column(
              children: [
                BannerSlider(banners: banners),
                SizedBox(height: 20.h),
                SectionTitle(title: 'Shop by Category'),
                SizedBox(
                  height: 110.h,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder:
                        (ctx, i) => Padding(
                          padding: EdgeInsets.only(right: 16.w),
                          child: CategoryCircle(
                            imageUrl:
                                categoryImageMap[categories[i].slug] ??
                                'https://images.pexels.com/photos/5082563/pexels-photo-5082563.jpeg?w=200&h=200&fit=crop',
                            name:
                                categories[i].name
                                    .replaceAll('-', ' ')
                                    .toTitleCase(),
                            onTap: () {},
                          ),
                        ),
                  ),
                ),
                SizedBox(height: 20.h),
                DealOfDayCard(
                  product: deal,
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailScreen(product: deal),
                        ),
                      ),
                ),
                SizedBox(height: 24.h),
                SectionTitle(title: 'Trending Products', onViewAll: () {}),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7, // ← PERFECT RATIO
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.w,
                  ),
                  padding: EdgeInsets.all(12.w),
                  itemCount: trending.length,
                  itemBuilder:
                      (ctx, i) => ProductCard(
                        product: trending[i],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) =>
                                      ProductDetailScreen(product: trending[i]),
                            ),
                          );
                        },
                      ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ← KEEP THE categoryImageMap HERE (same as before)
final Map<String, String> categoryImageMap = {
  'smartphones':
      'https://images.pexels.com/photos/607812/pexels-photo-607812.jpeg?w=200&h=200&fit=crop',
  'laptops':
      'https://images.pexels.com/photos/181 | https://images.pexels.com/photos/18105/pexels-photo.jpg?w=200&h=200&fit=crop',
  'fragrances':
      'https://images.pexels.com/photos/965989/pexels-photo-965989.jpeg?w=200&h=200&fit=crop',
  'skincare':
      'https://images.pexels.com/photos/4046316/pexels-photo-4046316.jpeg?w=200&h=200&fit=crop',
  'groceries':
      'https://images.pexels.com/photos/264636/pexels-photo-264636.jpeg?w=200&h=200&fit=crop',
  'home-decoration':
      'https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg?w=200&h=200&fit=crop',
  'furniture':
      'https://images.pexels.com/photos/1350789/pexels-photo-1350789.jpeg?w=200&h=200&fit=crop',
  'tops':
      'https://images.pexels.com/photos/5082563/pexels-photo-5082563.jpeg?w=200&h=200&fit=crop',
  'womens-dresses':
      'https://images.pexels.com/photos/6317699/pexels-photo-6317699.jpeg?w=200&h=200&fit=crop',
  'womens-shoes':
      'https://images.pexels.com/photos/2770450/pexels-photo-2770450.jpeg?w=200&h=200&fit=crop',
  'mens-shirts':
      'https://images.pexels.com/photos/1047330/pexels-photo-1047330.jpeg?w=200&h=200&fit=crop',
  'mens-shoes':
      'https://images.pexels.com/photos/2979337/pexels-photo-2979337.jpeg?w=200&h=200&fit=crop',
  'mens-watches':
      'https://images.pexels.com/photos/909907/pexels-photo-909907.jpeg?w=200&h=200&fit=crop',
  'womens-watches':
      'https://images.pexels.com/photos/949587/pexels-photo-949587.jpeg?w=200&h=200&fit=crop',
  'womens-bags':
      'https://images.pexels.com/photos/1152077/pexels-photo-1152077.jpeg?w=200&h=200&fit=crop',
  'womens-jewellery':
      'https://images.pexels.com/photos/3266700/pexels-photo-3266700.jpeg?w=200&h=200&fit=crop',
  'sunglasses':
      'https://images.pexels.com/photos/343720/pexels-photo-343720.jpeg?w=200&h=200&fit=crop',
  'automotive':
      'https://images.pexels.com/photos/3752192/pexels-photo-3752192.jpeg?w=200&h=200&fit=crop',
  'motorcycle':
      'https://images.pexels.com/photos/1413412/pexels-photo-1413412.jpeg?w=200&h=200&fit=crop',
  'lighting':
      'https://images.pexels.com/photos/1129413/pexels-photo-1129413.jpeg?w=200&h=200&fit=crop',
};
