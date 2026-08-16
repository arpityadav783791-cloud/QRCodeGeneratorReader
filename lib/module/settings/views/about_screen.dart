import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/theme/app_text_styles.dart';
import '../controllers/about_controller.dart';

class AboutScreen extends GetView<AboutController> {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About QR Vault',
          style: AppTextStyles.appBarTitle.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
        
              // =========================
              // APP ICON
              // =========================
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Icon(
                  Icons.qr_code_2,
                  size: 58,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
        
              const SizedBox(height: 20),
        
              // =========================
              // APP NAME
              // =========================
              Text(
                'QR Vault',
                style: AppTextStyles.headingLarge.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
        
              const SizedBox(height: 6),
        
              // =========================
              // VERSION
              // =========================
              Text(
                'Version 1.0.0',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
        
              const SizedBox(height: 18),
        
              // =========================
              // DESCRIPTION
              // =========================
              Text(
                'Scan, generate and manage your QR codes easily.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
        
              const SizedBox(height: 32),
        
              // =========================
              // FEATURES TITLE
              // =========================
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Features',
                  style: AppTextStyles.headingSmall.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
        
              const SizedBox(height: 12),
        
              // =========================
              // FEATURES
              // =========================
              Card(
                margin: EdgeInsets.zero,
                child: Column(
                  children: [
                    _FeatureTile(
                      icon: Icons.qr_code_scanner,
                      title: 'QR Scanner',
                      subtitle: 'Scan QR codes quickly and easily.',
                      colorScheme: colorScheme,
                    ),
        
                    Divider(height: 1, color: colorScheme.outlineVariant),
        
                    _FeatureTile(
                      icon: Icons.qr_code_2,
                      title: 'QR Generator',
                      subtitle: 'Create QR codes for different types of data.',
                      colorScheme: colorScheme,
                    ),
        
                    Divider(height: 1, color: colorScheme.outlineVariant),
        
                    _FeatureTile(
                      icon: Icons.history,
                      title: 'History',
                      subtitle:
                          'Keep track of your scanned and generated QR codes.',
                      colorScheme: colorScheme,
                    ),
        
                    Divider(height: 1, color: colorScheme.outlineVariant),
        
                    _FeatureTile(
                      icon: Icons.download_outlined,
                      title: 'Download',
                      subtitle: 'Download your generated QR codes.',
                      colorScheme: colorScheme,
                    ),
        
                    Divider(height: 1, color: colorScheme.outlineVariant),
        
                    _FeatureTile(
                      icon: Icons.share_outlined,
                      title: 'Share',
                      subtitle: 'Share your QR codes as images.',
                      colorScheme: colorScheme,
                    ),
        
                    Divider(height: 1, color: colorScheme.outlineVariant),
        
                    _FeatureTile(
                      icon: Icons.copy_outlined,
                      title: 'Copy',
                      subtitle: 'Copy QR content to your clipboard.',
                      colorScheme: colorScheme,
                    ),
                  ],
                ),
              ),
        
              const SizedBox(height: 32),
        
              // =========================
              // APP INFORMATION
              // =========================
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      Icon(Icons.qr_code_2, size: 32, color: colorScheme.primary),
        
                      const SizedBox(height: 10),
        
                      Text(
                        'QR Vault',
                        style: AppTextStyles.headingSmall.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
        
                      const SizedBox(height: 4),
        
                      Text(
                        'Your QR codes, stored simply.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        
              const SizedBox(height: 24),
        
              Text(
                'Made with Flutter',
                style: AppTextStyles.bodySmall.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
        
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================
// FEATURE TILE
// =========================

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final ColorScheme colorScheme;

  const _FeatureTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: colorScheme.onPrimaryContainer),
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyLarge.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.bodySmall.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
