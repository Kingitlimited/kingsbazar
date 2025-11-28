import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kingsbazar/core/routes/app_routes.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  Future<void> _onLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    await Future.delayed(const Duration(milliseconds: 800)); // mock delay

    setState(() => _isLoading = false);

    if (!mounted) return;

    /// Navigate to home after successful login (dummy)
    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Form(
        key: _formKey,
        child: Column(
          children: [

            // Email TextField
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Username or Email",
                prefixIcon: const Icon(Icons.person_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                filled: true,
                fillColor: const Color(0xFFF4F4F4),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email is required";
                }
                if (!value.contains("@")) {
                  return "Enter a valid email";
                }
                return null;
              },
            ),

            SizedBox(height: 16.h),

            // Password TextField
            TextFormField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                filled: true,
                fillColor: const Color(0xFFF4F4F4),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Password is required";
                }
                if (value.length < 6) {
                  return "Minimum 6 characters required";
                }
                return null;
              },
            ),

            SizedBox(height: 12.h),

            // Forgot Password Button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => context.push(AppRoutes.forgotPassword),
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFFE53950),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),

            // Login Button
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _onLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE53950),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: _isLoading
                    ? SizedBox(
                        width: 22.w,
                        height: 22.w,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),

            SizedBox(height: 20.h),

            // OR Continue With
            Text(
              "- OR Continue with -",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black54,
              ),
            ),

            SizedBox(height: 20.h),

            // Social Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _socialIcon("assets/icons/google.png"),
                SizedBox(width: 20.w),
                _socialIcon("assets/icons/apple.png"),
                SizedBox(width: 20.w),
                _socialIcon("assets/icons/facebook.png"),
              ],
            ),

            SizedBox(height: 20.h),

            // Create Account Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Create An Account ",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () => context.push(AppRoutes.signup),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFFE53950),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),

            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }

  Widget _socialIcon(String asset) {
    return Container(
      width: 48.w,
      height: 48.w,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE53950)),
        borderRadius: BorderRadius.circular(50.r),
      ),
      padding: EdgeInsets.all(10.w),
      child: Image.asset(asset),
    );
  }
}
