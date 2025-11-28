/// lib/core/widgets/components/banner_slider.dart
/// Beautiful Auto-Scrolling Banner Slider with Smooth Dots + Shimmer + Cached Images

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kingsbazar/core/constants/app_colors.dart';
import 'package:kingsbazar/models/banner_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatefulWidget {
  final List<BannerModel> banners;
  final double height;
  final bool autoPlay;
  final Duration autoPlayInterval;
  final BorderRadius borderRadius;

  const BannerSlider({
    Key? key,
    required this.banners,
    this.height = 180,
    this.autoPlay = true,
    this.autoPlayInterval = const Duration(seconds: 4),
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
  }) : super(key: key);

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) {
      return _buildShimmer();
    }

    return Column(
      children: [
        // ────── Carousel Slider ──────
        CarouselSlider(
          options: CarouselOptions(
            height: widget.height.h,
            viewportFraction: 0.94,
            autoPlay: widget.autoPlay,
            autoPlayInterval: widget.autoPlayInterval,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.25,
            onPageChanged: (index, reason) {
              setState(() => _currentIndex = index);
            },
          ),
          items: widget.banners.map((banner) {
            return Builder(builder: (context) {
              return GestureDetector(
                onTap: () {
                  // TODO: Handle banner tap (deep link, category, product)
                  debugPrint("Banner tapped: ${banner.title}");
                },
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                    borderRadius: widget.borderRadius,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: widget.borderRadius,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Banner Image
                        CachedNetworkImage(
                          imageUrl: banner.imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => _buildImageShimmer(),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                          ),
                        ),

                        // Gradient Overlay + Text
                        if (banner.title != null || banner.subtitle != null)
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.8),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (banner.title != null)
                                    Text(
                                      banner.title!,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  if (banner.subtitle != null)
                                    Text(
                                      banner.subtitle!,
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  if (banner.buttonText != null)
                                    SizedBox(height: 8.h),
                                  if (banner.buttonText != null)
                                    ElevatedButton(
                                      onPressed: () {
                                        debugPrint("Banner button: ${banner.buttonText}");
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.r),
                                        ),
                                      ),
                                      child: Text(
                                        banner.buttonText!,
                                        style: TextStyle(fontSize: 14.sp, color: Colors.white),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            });
          }).toList(),
        ),

        SizedBox(height: 16.h),

        // ────── Smooth Page Indicator ──────
        AnimatedSmoothIndicator(
          activeIndex: _currentIndex,
          count: widget.banners.length,
          effect: ExpandingDotsEffect(
            dotHeight: 8.h,
            dotWidth: 8.w,
            activeDotColor: AppColors.primary,
            dotColor: Colors.grey.shade300,
            expansionFactor: 4,
            spacing: 6.w,
            radius: 8.r,
          ),
        ),
      ],
    );
  }

  // ────── Shimmer for Loading State ──────
  Widget _buildShimmer() {
    return Container(
      height: widget.height.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: widget.borderRadius,
      ),
      child: _buildImageShimmer(),
    );
  }

  Widget _buildImageShimmer() {
    return Container(
      color: Colors.grey[200],
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
          strokeWidth: 2.5,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────
// QUICK USAGE WIDGET (for HomeScreen)
// ─────────────────────────────────────
class HomeBannerSlider extends StatelessWidget {
  final List<BannerModel> banners;

  const HomeBannerSlider({Key? key, required this.banners}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: BannerSlider(banners: banners),
    );
  }
}