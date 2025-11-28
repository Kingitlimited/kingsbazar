import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenUtilInitWrapper extends StatelessWidget {
  final Widget child;
  const ScreenUtilInitWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),     // Your Figma size
      minTextAdapt: true,
      splitScreenMode: true,
      fontSizeResolver: FontSizeResolvers.radius,  // Best for radius
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      child: child,
    );
  }
}