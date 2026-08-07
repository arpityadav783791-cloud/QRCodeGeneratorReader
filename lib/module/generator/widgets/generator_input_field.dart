import "package:flutter/material.dart";
import "package:qr_code_generator_reader/app/theme/app_colors.dart";
import "package:qr_code_generator_reader/app/theme/app_text_styles.dart";

class GeneratorInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final int maxLines;
  final bool obscureText;
  final Widget? suffixIcon;

  const GeneratorInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType,
      maxLines: maxLines,
      obscureText: obscureText,
      style: AppTextStyles.bodyLarge,

      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.hint,
        filled: true,
        fillColor: AppColors.surface,

        suffixIcon: suffixIcon,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }
}
