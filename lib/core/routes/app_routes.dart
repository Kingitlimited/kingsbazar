  
/// lib/core/routes/app_routes.dart
/// All named routes in one place – easy to manage & refactor

class AppRoutes {
  // Main Shell Routes (Bottom Navigation)
  static const String home = '/home';
  static const String category = '/category';
  static const String search = '/search';
  static const String wishlist = '/wishlist';
  static const String cart = '/cart';

  // Auth Flow
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';

  // Product Flow
  static const String productDetail = '/product-detail';
  static const String productList = '/product-list';

  // Checkout Flow
  static const String addressList = '/address-list';
  static const String addAddress = '/add-address';
  static const String checkout = '/checkout';
  static const String payment = '/payment';
  static const String orderSuccess = '/order-success';

  // Profile & Settings
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String myOrders = '/my-orders';
  static const String orderDetail = '/order-detail';
  static const String myAddresses = '/my-addresses';
  static const String helpSupport = '/help-support';
  static const String aboutUs = '/about-us';
  static const String settings = '/settings';

  // Prevent instantiation
  AppRoutes._();
}