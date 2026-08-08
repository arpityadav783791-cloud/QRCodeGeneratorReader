import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_generator_reader/app/utils/app_snackbar.dart';

import '../../../app/routes/app_routes.dart';
import '../controllers/url_generator_controller.dart';
import '../widgets/base_generator_screen.dart';
import '../widgets/generator_input_field.dart';

class UrlGeneratorScreen extends GetView<UrlGeneratorController> {
  const UrlGeneratorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseGeneratorScreen(
      title: "URL",

      qrData: controller.qrData,

      onClear: controller.clear,

      onCustomize: () {
        AppSnackbar.show(
          title: "Coming Soon", 
          message: "QR customization will be available soon.");
      },

      onContinue: () {
        if (controller.urlController.text.trim().isEmpty) {
          AppSnackbar.show(
            title: "Empty URL", 
            message: "Please enter a URL."
          );
          return;
        }

        Get.toNamed(AppRoutes.qrPreview, arguments: controller.qrData.value);
      },

      inputFields: [
        GeneratorInputField(
          controller: controller.urlController,
          hintText: "https://example.com",
          keyboardType: TextInputType.url,
          onChanged: controller.updateQR,
        ),
      ],
    );
  }
}
