import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kingsbazar/core/routes/app_routes.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _loading = false;

  Future<void> _onSignup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    await Future.delayed(const Duration(milliseconds: 900)); // mock delay

    setState(() => _loading = false);

    if (!mounted) return;

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
            /// FULL NAME
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: "Full Name",
                prefixIcon: const Icon(Icons.person_outline),
                filled: true,
                fillColor: const Color(0xFFF4F4F4),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Full name is required";
                }
                return null;
              },
            ),

            SizedBox(height: 16.h),

            /// EMAIL
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "Email Address",
                prefixIcon: const Icon(Icons.email_outlined),
                filled: true,
                fillColor: const Color(0xFFF4F4F4),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
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

            /// PASSWORD
            TextFormField(
              controller: _passwordController,
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: const Icon(Icons.lock_outline),
                filled: true,
                fillColor: const Color(0xFFF4F4F4),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
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

            SizedBox(height: 16.h),

            /// CONFIRM PASSWORD
            TextFormField(
              controller: _confirmController,
              obscureText: !_confirmPasswordVisible,
              decoration: InputDecoration(
                hintText: "Confirm Password",
                prefixIcon: const Icon(Icons.lock_outline),
                filled: true,
                fillColor: const Color(0xFFF4F4F4),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _confirmPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _confirmPasswordVisible =
                          !_confirmPasswordVisible;
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value != _passwordController.text) {
                  return "Passwords do not match";
                }
                return null;
              },
            ),

            SizedBox(height: 20.h),

            /// SIGNUP BUTTON
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: _loading ? null : _onSignup,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE53950),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: _loading
                    ? SizedBox(
                        height: 22.h,
                        width: 22.h,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),

            SizedBox(height: 20.h),

            /// OR CONTINUE WITH
            Text(
              "- OR Continue with -",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black54,
              ),
            ),

            SizedBox(height: 20.h),

            /// SOCIAL ICONS
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

            /// NAVIGATE TO LOGIN
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () => context.push(AppRoutes.login),
                  child: Text(
                    "Log In",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFFE53950),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
