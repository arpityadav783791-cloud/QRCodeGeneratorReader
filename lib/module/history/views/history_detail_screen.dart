import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_generator_reader/app/theme/app_text_styles.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/history_detail_controller.dart';

class HistoryDetailScreen extends GetView<HistoryDetailController> {
  const HistoryDetailScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
    final ColorScheme = Theme.of(context).colorScheme;
    final GlobalKey qrKey = GlobalKey();
    return Scaffold(
      appBar: AppBar(title: const Text('History Details'), centerTitle: true),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // QR
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: ColorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: RepaintBoundary(
                  key: qrKey,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(20),
                    child: QrImageView(
                      data: controller.item.content,
                      size: 260,
                      version: QrVersions.auto,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Source + Type
              Row(
                children: [
                  Chip(
                    label: Text(
                      controller.sourceLabel,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: ColorScheme.onSecondaryContainer,
                      ),
                    ),
                    backgroundColor: ColorScheme.secondaryContainer,
                  ),

                  const SizedBox(width: 8),

                  Chip(
                    label: Text(
                      controller.typeLabel,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: ColorScheme.primary,
                      ),
                    ),
                    backgroundColor: ColorScheme.primaryContainer,
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Generated / scanned date
              Text(
                _formatDate(controller.item.createdAt),
                style: AppTextStyles.bodyMedium.copyWith(
                  color: ColorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Content',
                style: AppTextStyles.headingSmall.copyWith(
                  color: ColorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: ColorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: SelectableText(
                  controller.item.content,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: ColorScheme.onSurface,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            controller.downloadQR(qrKey);
                          },
                          icon: const Icon(Icons.download),
                          label: const Text('Download'),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            controller.shareQR(qrKey);
                          },
                          icon: const Icon(Icons.share),
                          label: const Text('Share'),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: controller.copyQR,
                      icon: const Icon(Icons.copy),
                      label: const Text('Copy'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year} "
        "${date.hour.toString().padLeft(2, '0')}:"
        "${date.minute.toString().padLeft(2, '0')}";
  }
}
