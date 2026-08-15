import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_generator_reader/app/routes/app_routes.dart';

import '../controllers/settings_controller.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // =========================
          // GENERAL
          // =========================
          const _SettingsSectionTitle(title: 'General'),

          Card(
            margin: EdgeInsets.zero,
            child: Column(
              children: [
                GetBuilder<SettingsController>(
                  builder: (controller) {
                    return ListTile(
                      leading: const Icon(Icons.palette_outlined),
                      title: const Text('Appearance'),
                      subtitle: Text(controller.themeLabel),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        _showThemeDialog(context);
                      },
                    );
                  },
                ),

                const Divider(height: 1),

                ListTile(
                  leading: const Icon(Icons.notifications_none_outlined),
                  title: const Text('Notifications'),
                  subtitle: const Text('Manage app notifications'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // =========================
          // HISTORY
          // =========================
          const _SettingsSectionTitle(title: 'History'),

          Card(
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: const Icon(Icons.history),
              title: const Text('History'),
              subtitle: const Text(
                'Manage your scanned and generated QR history',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Get.toNamed(AppRoutes.history);
              },
            ),
          ),

          const SizedBox(height: 24),

          // =========================
          // ABOUT
          // =========================
          const _SettingsSectionTitle(title: 'About'),

          Card(
            margin: EdgeInsets.zero,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('About QR Vault'),
                  subtitle: const Text('Learn more about the application'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),

                const Divider(height: 1),

                const ListTile(
                  leading: Icon(Icons.phone_android_outlined),
                  title: Text('App Version'),
                  trailing: Text('1.0.0'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // =========================
          // APP FOOTER
          // =========================
          Center(
            child: Text(
              'QR Vault',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),

          const SizedBox(height: 6),

          Center(
            child: Text(
              'Your QR codes, stored simply.',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // =========================
  // THEME DIALOG
  // =========================

  void _showThemeDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text('Choose Theme'),

        content: GetBuilder<SettingsController>(
          builder: (controller) {
            return RadioGroup<ThemeMode>(
              groupValue: controller.themeMode,

              onChanged: (value) {
                if (value == null) {
                  return;
                }

                controller.changeTheme(value);

                Get.back();
              },

              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<ThemeMode>(
                    value: ThemeMode.system,
                    title: Text('System'),
                  ),

                  RadioListTile<ThemeMode>(
                    value: ThemeMode.light,
                    title: Text('Light'),
                  ),

                  RadioListTile<ThemeMode>(
                    value: ThemeMode.dark,
                    title: Text('Dark'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// =========================
// SECTION TITLE
// =========================

class _SettingsSectionTitle extends StatelessWidget {
  final String title;

  const _SettingsSectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 10),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
