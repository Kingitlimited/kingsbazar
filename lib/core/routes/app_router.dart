import 'package:go_router/go_router.dart';
import 'package:kingsbazar/core/routes/app_routes.dart';
import 'package:kingsbazar/core/widgets/main_scaffold.dart';
import 'package:kingsbazar/features/onboarding/presentation/onboarding_screen.dart';
import 'package:kingsbazar/features/auth/presentation/login_screen.dart';
import 'package:kingsbazar/features/auth/presentation/signup_screen.dart';
import 'package:kingsbazar/features/home/presentation/home_screen.dart';
import 'package:kingsbazar/features/category/presentation/all_categories_screen.dart';
import 'package:kingsbazar/features/search/presentation/search_screen.dart';
import 'package:kingsbazar/features/wishlist/presentation/wishlist_screen.dart';
import 'package:kingsbazar/features/cart/presentation/cart_screen.dart';
import 'package:kingsbazar/features/product/presentation/product_detail_screen.dart';
import 'package:kingsbazar/features/checkout/presentation/checkout_payment_screen.dart';
import 'package:kingsbazar/features/order/presentation/order_success_screen.dart';
import 'package:kingsbazar/features/profile/presentation/profile_main_screen.dart';
import 'package:kingsbazar/models/product_model.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    // ──────── ONBOARDING & AUTH (No Bottom Nav) ────────
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingScreen(), // create later
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.signup,
      builder: (context, state) => const SignupScreen(),
    ),

    // ──────── MAIN APP WITH BOTTOM NAVIGATION ────────
    ShellRoute(
      builder: (context, state, child) => MainScaffold(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: AppRoutes.category,
          builder: (context, state) => const CategoryScreen(),
        ),
        GoRoute(
          path: AppRoutes.search,
          builder: (context, state) => const SearchScreen(),
        ),
        GoRoute(
          path: AppRoutes.wishlist,
          builder: (context, state) => const WishlistScreen(),
        ),
        GoRoute(
          path: AppRoutes.cart,
          builder: (context, state) => const CartScreen(),
        ),
      ],
    ),

    // ──────── FULL SCREEN ROUTES (on top of shell) ────────
    GoRoute(
      path: AppRoutes.productDetail,
      builder: (context, state) {
        final product = state.extra as ProductModel;
        return ProductDetailScreen(product: product);
      },
    ),
    GoRoute(
      path: AppRoutes.checkout,
      builder: (context, state) => const CheckoutScreen(),
    ),
    GoRoute(
      path: AppRoutes.orderSuccess,
      builder: (context, state) => const OrderSuccessScreen(),
    ),
    GoRoute(
      path: AppRoutes.profile,
      builder: (context, state) => const ProfileScreen(),
    ),
  ],

  // Optional: Redirect logic (e.g. if not logged in)
  // redirect: (context, state) {
  //   final isLoggedIn = false; // connect to auth provider later
  //   final isAuthRoute = [AppRoutes.login, AppRoutes.signup, AppRoutes.onboarding].contains(state.uri.path);
  //   if (!isLoggedIn && !isAuthRoute) return AppRoutes.login;
  //   return null;
  // },
);