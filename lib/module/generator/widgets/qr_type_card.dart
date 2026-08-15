import 'package:flutter/material.dart';
import 'package:qr_code_generator_reader/app/theme/app_colors.dart';

class QRTypeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool selected;
  final Color? iconColor;

  const QRTypeCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.selected = false,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final Color cardColor = selected
        ? colorScheme.primary
        : colorScheme.surfaceContainerHighest;

    final Color borderColor = selected
        ? colorScheme.primary
        : colorScheme.outlineVariant;

    final Color iconColorValue = selected
        ? colorScheme.onPrimary
        : iconColor ?? colorScheme.onSurface;

    final Color textColor = selected
        ? colorScheme.onPrimary
        : colorScheme.onSurfaceVariant;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 30, color: iconColorValue),

                const SizedBox(height: 10),

                Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
