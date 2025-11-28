import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kingsbazar/core/routes/app_routes.dart';
import 'package:kingsbazar/features/auth/presentation/widgets/auth_header.dart';
import 'package:kingsbazar/features/auth/presentation/widgets/signup_form.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Header (Create an account)
              const AuthHeader(
                title: "Create an\nAccount",
              ),

              /// Signup Form
              const SignupForm(),

              SizedBox(height: 20.h),

              /// Already have an account? Log in
              Center(
                child: GestureDetector(
                  onTap: () => context.go(AppRoutes.login),
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: "Log In",
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

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
