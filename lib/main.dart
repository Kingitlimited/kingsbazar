/// lib/main.dart
/// THIS IS THE REAL ONE — NO LIES, NO INVENTED FILES

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kingsbazar/config/app_config.dart';
import 'package:kingsbazar/core/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  runApp(
    const ProviderScope(
      child: KingsBazarApp(),
    ),
  );
}

class KingsBazarApp extends StatelessWidget {
  const KingsBazarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'KingsBazar',
          debugShowCheckedModeBanner: false,
          routerConfig: router,               // ← This is the real global router from app_router.dart
          theme: ThemeData(
            fontFamily: 'Poppins',
            scaffoldBackgroundColor: const Color(0xFFFAFAFA),
            useMaterial3: true,
          ),
        );
      },
    );
  }
}