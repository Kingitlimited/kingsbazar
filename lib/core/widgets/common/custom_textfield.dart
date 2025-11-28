/// lib/core/widgets/common/custom_textfield.dart
/// Fully fixed & working – no 'focus' error

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kingsbazar/core/constants/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final FocusNode? focusNode;                    // Fixed: renamed from 'focus'
  final TextCapitalization textCapitalization;

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.onTap,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,                             // Fixed here
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: _obscureText,
      validator: widget.validator,
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      focusNode: widget.focusNode,                // Fixed: now correct
      textCapitalization: widget.textCapitalization,
      style: TextStyle(fontSize: 15.sp, color: AppColors.textPrimary, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14.sp),
        prefixIcon: widget.prefixIcon != null
            ? Padding(padding: EdgeInsets.symmetric(horizontal: 16.w), child: widget.prefixIcon)
            : null,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: Colors.grey.shade600,
                  size: 22.sp,
                ),
                onPressed: () => setState(() => _obscureText = !_obscureText),
              )
            : widget.suffixIcon,
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: AppColors.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: AppColors.error, width: 2),
        ),
        counterText: '',
      ),
    );
  }
}

// ─────────────────────────────────────
// Pre-built variants (unchanged)
// ─────────────────────────────────────
class EmailTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  const EmailTextField({Key? key, this.controller, this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      focusNode: focusNode,
      hintText: 'Enter your email',
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Icon(Icons.email_outlined, color: AppColors.primary),
      validator: (v) => v!.isEmpty ? 'Enter email' : (!v.contains('@') ? 'Invalid email' : null),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  const PasswordTextField({Key? key, this.controller, this.hint = 'Enter password'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      hintText: hint,
      obscureText: true,
      prefixIcon: const Icon(Icons.lock_outline, color: AppColors.primary),
      validator: (v) => v!.isEmpty ? 'Enter password' : (v.length < 6 ? 'Min 6 characters' : null),
    );
  }
}

class SearchTextField extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;
  const SearchTextField({Key? key, this.controller, this.onTap, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      hintText: 'Search products, brands...',
      readOnly: onTap != null,
      onTap: onTap,
      onChanged: onChanged,
      prefixIcon: const Icon(Icons.search, color: Colors.grey),
    );
  }
}