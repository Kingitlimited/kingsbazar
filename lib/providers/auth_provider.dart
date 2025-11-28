
/// lib/providers/auth_provider.dart
/// Complete Auth Provider – Login, Register, Logout, Guest Mode
/// Works with DummyJSON Auth + supports Guest flow

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:kingsbazar/models/user_model.dart';
import 'package:kingsbazar/providers/app_state_provider.dart';
import 'package:kingsbazar/services/api/api_service.dart';

/// ──────────────────────────────────────
/// 1. Auth State Notifier
/// ──────────────────────────────────────
class AuthNotifier extends StateNotifier<AsyncValue<UserModel>> {
  AuthNotifier() : super(AsyncValue.data(guestUser)) {
    // Auto-check saved session on app start
    _checkSavedLogin();
  }

  // Current user (guest or logged-in)
  UserModel get user => state.value ?? guestUser;
  bool get isLoggedIn => !user.isGuest;

  // ────── Login with DummyJSON ──────
  Future<void> login({
    required String username,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    try {
      final response = await apiService.post(
        '/auth/login',
        data: {
          'username': username,   // DummyJSON uses username, not email
          'password': password,
          // Popular test accounts:
          // kminchelle / 0lelplR
          // atuny0     / 9uQFF1Lh
          // hbingley1  / CQutx25i8r
        },
      );

      final userJson = response.data;
      final loggedInUser = UserModel(
        id: userJson['id'].toString(),
        email: userJson['email'],
        phone: userJson['phone'],
        fullName: '${userJson['firstName']} ${userJson['lastName']}',
        avatarUrl: userJson['image'],
        gender: userJson['gender'] == 'male' ? Gender.male : Gender.female,
        isEmailVerified: true,
        isPhoneVerified: true,
      );

      state = AsyncValue.data(loggedInUser);

      // Save to secure storage / Hive later
      _saveLoginSession(loggedInUser);

      showGlobalSnackBar(message: 'Welcome back, ${loggedInUser.displayName}!', success: true);
    } on DioException catch (e) {
      String msg = 'Login failed';
      if (e.response?.statusCode == 400) {
        msg = 'Invalid username or password';
      } else if (e.type == DioExceptionType.connectionTimeout) {
        msg = 'Connection timeout';
      }

      state = AsyncValue.error(msg, StackTrace.current);
      showGlobalSnackBar(message: msg, success: false);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      showGlobalSnackBar(message: 'Something went wrong', success: false);
    }
  }

  // ────── Register (DummyJSON supports it!) ──────
  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phone,
  }) async {
    state = const AsyncValue.loading();

    try {
      final response = await apiService.post('/users/add', data: {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'phone': phone,
      });

      final newUser = UserModel(
        id: response.data['id'].toString(),
        email: email,
        fullName: '$firstName $lastName',
        phone: phone,
        isEmailVerified: false,
        isPhoneVerified: false,
      );

      state = AsyncValue.data(newUser);
      _saveLoginSession(newUser);

      showGlobalSnackBar(message: 'Account created successfully!', success: true);
    } catch (e) {
      String msg = e.toString().contains('email') ? 'Email already exists' : 'Registration failed';
      state = AsyncValue.error(msg, StackTrace.current);
      showGlobalSnackBar(message: msg, success: false);
    }
  }

  // ────── Logout ──────
  Future<void> logout() async {
    state = AsyncValue.data(guestUser);
    // Clear saved session
    // await secureStorage.delete(key: 'user_session');
    showGlobalSnackBar(message: 'Logged out successfully');
  }

  // ────── Guest Mode (already default) ──────
  void continueAsGuest() {
    state = AsyncValue.data(guestUser);
  }

  // ────── Private Helpers ──────
  void _saveLoginSession(UserModel user) {
    // TODO: Save to Hive / SharedPreferences / SecureStorage
    // Example: await Hive.box('auth').put('current_user', user.toJson());
  }

  Future<void> _checkSavedLogin() async {
    // TODO: Load from Hive / SecureStorage
    // final saved = Hive.box('auth').get('current_user');
    // if (saved != null) state = AsyncValue.data(UserModel.fromJson(saved));
  }
}

// ──────────────────────────────────────
// Providers
// ──────────────────────────────────────
final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<UserModel>>((ref) {
  return AuthNotifier();
});

// Quick access to current user
final currentUserProvider = Provider<UserModel>((ref) {
  return ref.watch(authProvider).value ?? guestUser;
});

// Is user logged in?
final isUserLoggedInProvider = Provider<bool>((ref) {
  return ref.watch(currentUserProvider).isGuest == false;
});
