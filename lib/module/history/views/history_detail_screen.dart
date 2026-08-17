import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_generator_reader/app/theme/app_text_styles.dart';
import 'package:qr_code_generator_reader/app/utils/app_snackbar.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/history_detail_controller.dart';
import 'package:qr_code_generator_reader/module/shared/models/qr_action_type.dart';
import 'package:qr_code_generator_reader/module/shared/models/qr_context_action.dart';

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
                  // Context-aware actions
                  if (controller.contextualActions.isNotEmpty) ...[
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: controller.contextualActions.map((
                        contextAction,
                      ) {
                        return _ContextActionButton(
                          action: contextAction,
                          onPressed: () async {
                            final success = await controller
                                .executeContextualAction(contextAction);

                            if (!success) {
                              AppSnackbar.show(
                                title: 'Unable to Perform Action',
                                message:
                                    'The requested action could not be completed.',
                              );
                            }
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 16),
                  ],

                  // Existing Download + Share
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

                  // Existing Copy
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

class _ContextActionButton extends StatelessWidget {
  final QRContextAction action;
  final VoidCallback onPressed;

  const _ContextActionButton({required this.action, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      icon: Icon(_icon),
      label: Text(_label),
    );
  }

  IconData get _icon {
    switch (action.action) {
      case QRActionType.pay:
        return Icons.payment;

      case QRActionType.call:
        return Icons.call;

      case QRActionType.sendSms:
        return Icons.sms_outlined;

      case QRActionType.openLink:
        return Icons.open_in_browser;

      case QRActionType.sendEmail:
        return Icons.email_outlined;

      case QRActionType.openMaps:
        return Icons.location_on_outlined;
    }
  }

  String get _label {
    switch (action.action) {
      case QRActionType.pay:
        return 'Pay';

      case QRActionType.call:
        return 'Call';

      case QRActionType.sendSms:
        return 'Send SMS';

      case QRActionType.openLink:
        return 'Open Link';

      case QRActionType.sendEmail:
        return 'Send Email';

      case QRActionType.openMaps:
        return 'Open Maps';
    }
  }
}
