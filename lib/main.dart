import 'package:flutter/material.dart';
import 'utils/app_colors.dart';
import 'screens/main_shell.dart';

void main() {
  runApp(const AdoPetApp());
}

class AdoPetApp extends StatelessWidget {
  const AdoPetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AdoPet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: const MainShell(),
    );
  }
}
