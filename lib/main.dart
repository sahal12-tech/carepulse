import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/core/theme/app_theme.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(const CarePulseApp());
}

class CarePulseApp extends StatelessWidget {
  const CarePulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CarePulse',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppPages.initialRoute,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
