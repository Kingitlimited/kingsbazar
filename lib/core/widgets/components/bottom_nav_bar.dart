  
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kingsbazar/core/constants/app_colors.dart';
import 'package:kingsbazar/core/utils/extensions.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final int cartCount;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    this.cartCount = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2))],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 10.sp,
        unselectedFontSize: 10.sp,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/category');
              break;
            case 2:
              context.go('/search');
              break;
            case 3:
              context.go('/wishlist');
              break;
            case 4:
              context.go('/cart');
              break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Category'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Wishlist'),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.shopping_bag_outlined),
                if (cartCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                      child: Text(
                        cartCount.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}