/// lib/config/app_config.dart
/// Simple config — easy to switch from DummyJSON to real backend later

class AppConfig {
  // Change this to false when you connect real backend (Shopify, WooCommerce, etc.)
  static const bool useDummyJson = true;

  // DummyJSON API (for development & demo)
  static const String dummyJsonBaseUrl = 'https://dummyjson.com';

  // Future real backend — just change the flag above
  // static const String apiBaseUrl = 'https://your-real-api.com/v1';
  // static const String imageCdnUrl = 'https://cdn.yourshop.com';

  // Prevent instantiation
  AppConfig._();
}