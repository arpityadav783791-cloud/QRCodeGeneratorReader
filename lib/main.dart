import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:qr_code_generator_reader/app/bindings/app_binding.dart';
import 'package:qr_code_generator_reader/app/routes/app_pages.dart';
import 'package:qr_code_generator_reader/app/routes/app_routes.dart';
import 'package:qr_code_generator_reader/app/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();

  final savedTheme = preferences.getString('theme_mode');

  ThemeMode initialThemeMode;

  switch (savedTheme) {
    case 'light':
      initialThemeMode = ThemeMode.light;
      break;

    case 'dark':
      initialThemeMode = ThemeMode.dark;
      break;

    default:
      initialThemeMode = ThemeMode.system;
  }

  runApp(QRVaultApp(initialThemeMode: initialThemeMode));
}

class QRVaultApp extends StatelessWidget {
  final ThemeMode initialThemeMode;

  const QRVaultApp({super.key, required this.initialThemeMode});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Vault',

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: initialThemeMode,

      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
      initialBinding: AppBinding(),
    );
  }
}
