  
// lib/features/profile/presentation/profile_main_screen.dart
import 'package:flutter/material.dart';
import 'package:kingsbazar/core/constants/app_colors.dart';
import 'package:kingsbazar/core/utils/extensions.dart';

class ProfileMainScreen extends StatelessWidget {
  const ProfileMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primary,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          CircleAvatar(radius: 50.r, backgroundColor: AppColors.primary, child: Icon(Icons.person, size: 60.sp, color: Colors.white)),
          SizedBox(height: 16.h),
          Text('Welcome Back!', textAlign: TextAlign.center, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
          Text('guest@kingsbazar.com', textAlign: TextAlign.center, style: TextStyle(color: AppColors.textSecondary)),

          SizedBox(height: 24.h),
          _buildProfileTile(Icons.person_outline, 'Edit Profile'),
          _buildProfileTile(Icons.location_on_outlined, 'My Addresses'),
          _buildProfileTile(Icons.favorite_border, 'Wishlist'),
          _buildProfileTile(Icons.shopping_bag_outlined, 'My Orders'),
          _buildProfileTile(Icons.card_giftcard, 'Coupons'),
          _buildProfileTile(Icons.help_outline, 'Help Center'),
          _buildProfileTile(Icons.logout, 'Log Out', color: Colors.red),
        ],
      ),
    );
  }

  Widget _buildProfileTile(IconData icon, String title, {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppColors.primary),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
      onTap: () {},
    );
  }
}