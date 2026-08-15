
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController {
  static const String _themeKey = 'theme_mode';

  ThemeMode themeMode = ThemeMode.system;

  late SharedPreferences _preferences;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    _preferences = await SharedPreferences.getInstance();

    final savedTheme = _preferences.getString(_themeKey);

    switch (savedTheme) {
      case 'light':
        themeMode = ThemeMode.light;
        break;

      case 'dark':
        themeMode = ThemeMode.dark;
        break;

      default:
        themeMode = ThemeMode.system;
    }

    Get.changeThemeMode(themeMode);

    update();
  }

  Future<void> changeTheme(ThemeMode mode) async {
    themeMode = mode;

    await _preferences.setString(_themeKey, mode.name);

    Get.changeThemeMode(mode);

    update();
  }

  String get themeLabel {
    switch (themeMode) {
      case ThemeMode.light:
        return 'Light';

      case ThemeMode.dark:
        return 'Dark';

      case ThemeMode.system:
        return 'System';
    }
  }
}
