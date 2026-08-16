import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../app/theme/app_text_styles.dart';

import 'generator_action_buttons.dart';
import 'qr_preview_card.dart';

class BaseGeneratorScreen extends StatelessWidget {
  final String title;

  final List<Widget> inputFields;

  final RxString qrData;
  final VoidCallback onContinue;
  final VoidCallback onCustomize;
  final VoidCallback onClear;
  const BaseGeneratorScreen({

    super.key,
    required this.title,
    required this.inputFields,
    required this.qrData,
    required this.onContinue,
    required this.onCustomize,
    required this.onClear,

  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScheme.surface,

        title: Text(title, style: AppTextStyles.headingMedium),

        actions: [
          IconButton(onPressed: onClear, icon: const Icon(Icons.clear)),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Enter $title", style: AppTextStyles.headingSmall),

              const SizedBox(height: 16),

              ...inputFields,

              const SizedBox(height: 30),

              QRPreviewCard(qrData: qrData),

              const SizedBox(height: 30),

              GeneratorActionButtons(
                onCustomize: onCustomize,
                onContinue: onContinue,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
