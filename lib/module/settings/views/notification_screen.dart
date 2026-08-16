import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/theme/app_text_styles.dart';
import '../controllers/notification_controller.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: AppTextStyles.appBarTitle.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // =========================
          // NOTIFICATION SETTINGS
          // =========================
          Text(
            'Notification Settings',
            style: AppTextStyles.headingSmall.copyWith(
              color: colorScheme.primary,
            ),
          ),

          const SizedBox(height: 12),

          Card(
            margin: EdgeInsets.zero,
            child: GetBuilder<NotificationController>(
              builder: (controller) {
                if (controller.isLoading) {
                  return const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                return SwitchListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  secondary: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.notifications_outlined,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  title: Text(
                    'Enable Notifications',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    controller.notificationsEnabled
                        ? 'Notifications are enabled'
                        : 'Notifications are disabled',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  value: controller.notificationsEnabled,
                  onChanged: controller.toggleNotifications,
                );
              },
            ),
          ),

          const SizedBox(height: 28),

          // =========================
          // INFORMATION
          // =========================
          Text(
            'About Notifications',
            style: AppTextStyles.headingSmall.copyWith(
              color: colorScheme.primary,
            ),
          ),

          const SizedBox(height: 12),

          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, color: colorScheme.primary),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      'When notifications are enabled, QR Vault can '
                      'show notifications when notification features '
                      'are available.',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
