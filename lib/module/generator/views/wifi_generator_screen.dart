import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_generator_reader/app/routes/app_routes.dart';
import 'package:qr_code_generator_reader/app/theme/app_colors.dart';
import 'package:qr_code_generator_reader/app/utils/app_snackbar.dart';

import '../controllers/wifi_generator_controller.dart';
import '../widgets/base_generator_screen.dart';
import '../widgets/generator_input_field.dart';

class WifiGeneratorScreen extends GetView<WifiGeneratorController> {
  const WifiGeneratorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseGeneratorScreen(
      title: "WiFi",

      qrData: controller.qrData,

      onClear: controller.clear,

      onCustomize: () {
        AppSnackbar.show(
          title: "Coming Soon", 
          message: "QR customization will be available soon."
        );
      },

      onContinue: () {
        if (controller.ssidController.text.trim().isEmpty) {
          AppSnackbar.show(
            title: "Empty SSID", 
            message: "Please enter your WiFi name.");
          return;
        }

        controller.generateQR();

        Get.toNamed(AppRoutes.qrPreview, arguments: controller.qrData.value);
      },

      inputFields: [
        GeneratorInputField(
          controller: controller.ssidController,
          hintText: "WiFi Name (SSID)",
          onChanged: (_) => controller.generateQR(),
        ),

        const SizedBox(height: 16),

        GeneratorInputField(
          controller: controller.passwordController,
          hintText: "Password",
          obscureText: true,
          onChanged: (_) => controller.generateQR(),
        ),

        const SizedBox(height: 16),

        Obx(
          () => DropdownButtonFormField<String>(
            value: controller.selectedSecurity.value,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
            items: const [
              DropdownMenuItem(value: "WPA", child: Text("WPA")),
              DropdownMenuItem(value: "WEP", child: Text("WEP")),
              DropdownMenuItem(value: "Open", child: Text("Open")),
            ],
            onChanged: (value) {
              if (value != null) {
                controller.selectedSecurity.value = value;
                controller.generateQR();
              }
            },
          ),
        ),
      ],
    );
  }
}
