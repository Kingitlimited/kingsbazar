import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kingsbazar/features/auth/presentation/widgets/auth_header.dart';
import 'package:kingsbazar/features/auth/presentation/widgets/login_form.dart';
import 'package:kingsbazar/core/routes/app_routes.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Header (Welcome Back!)
              const AuthHeader(
                title: "Welcome\nBack!",
              ),

              /// Login Form
              const LoginForm(),

              SizedBox(height: 10.h),

              /// Don't have an account? Sign up
              Center(
                child: GestureDetector(
                  onTap: () => context.push(AppRoutes.signup),
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: "Sign Up",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color(0xFFE53950),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
