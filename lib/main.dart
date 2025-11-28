import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/utils/screen_util.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_router.dart';

void main() {
  runApp(const ProviderScope(child: KingsBazarApp()));
}

class KingsBazarApp extends StatelessWidget {
  const KingsBazarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInitWrapper(
      child: MaterialApp.router(
        title: 'KingsBazar',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        routerConfig: router,
      ),
    );
  }
}