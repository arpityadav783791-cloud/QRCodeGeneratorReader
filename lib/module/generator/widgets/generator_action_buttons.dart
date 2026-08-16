import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class GeneratorActionButtons extends StatelessWidget {
  final VoidCallback onCustomize;
  final VoidCallback onContinue;

  const GeneratorActionButtons({
    super.key,
    required this.onCustomize,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton.icon(
            onPressed: onCustomize,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            icon: const Icon(Icons.tune),
            label: Text(
              "Customize", 
              style: AppTextStyles.button.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        ),

        const SizedBox(height: 18),

        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton.icon(
            onPressed: onContinue,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.success,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            icon: const Icon(Icons.qr_code_2),
            label: Text(
              "Next",
              style: AppTextStyles.button.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
