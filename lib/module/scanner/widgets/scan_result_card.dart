import 'package:flutter/material.dart';
import 'package:qr_code_generator_reader/app/theme/app_colors.dart';
import 'package:qr_code_generator_reader/app/theme/app_text_styles.dart';

class ScanResultCard extends StatelessWidget{
  final String data;
  const ScanResultCard({
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context){
    final ColorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: ColorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SelectableText(
        data.isEmpty?"No QR Code Scanned": data,
        style: AppTextStyles.bodyLarge.copyWith(color: ColorScheme.onSurface),
      ),
    );
  }
}