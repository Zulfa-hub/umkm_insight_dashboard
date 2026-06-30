// lib/main.dart
// Entry point UMKM Insight Dashboard
// Aplikasi Monitoring Produk dan Penjualan Berbasis REST API

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/dashboard_screen.dart';
import 'widgets/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  runApp(const UmkmInsightApp());
}

class UmkmInsightApp extends StatelessWidget {
  const UmkmInsightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UMKM Insight Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ).copyWith(
          primary: AppColors.primary,
          secondary: AppColors.accent,
          surface: AppColors.surface,
        ),
        scaffoldBackgroundColor: AppColors.background,
        cardTheme: CardThemeData(
          color: AppColors.surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.border),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
        fontFamily: 'Roboto',
      ),
      home: const DashboardScreen(),
    );
  }
}