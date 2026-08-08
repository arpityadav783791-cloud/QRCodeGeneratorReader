import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_generator_reader/app/utils/app_snackbar.dart';

import '../../../app/routes/app_routes.dart';
import '../controllers/sms_generator_controller.dart';
import '../widgets/base_generator_screen.dart';
import '../widgets/generator_input_field.dart';

class SmsGeneratorScreen extends GetView<SmsGeneratorController> {
  const SmsGeneratorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseGeneratorScreen(
      title: "SMS",

      qrData: controller.qrData,

      onClear: controller.clear,

      onCustomize: () {
        AppSnackbar.show(
          title: "Coming Soon", 
          message: "QR customization will be available soon."
        );
      },

      onContinue: () {
        if (controller.phoneController.text.trim().isEmpty) {
          AppSnackbar.show(
            title: "Empty Phone", 
            message: "Please enter a phone number."
          );

          return;
        }

        controller.generateQR();

        Get.toNamed(AppRoutes.qrPreview, arguments: controller.qrData.value);
      },

      inputFields: [
        GeneratorInputField(
          controller: controller.phoneController,
          hintText: "Phone Number",
          keyboardType: TextInputType.phone,
          onChanged: (_) => controller.generateQR(),
        ),

        const SizedBox(height: 16),

        GeneratorInputField(
          controller: controller.messageController,
          hintText: "Message",
          maxLines: 4,
          onChanged: (_) => controller.generateQR(),
        ),
      ],
    );
  }
}
