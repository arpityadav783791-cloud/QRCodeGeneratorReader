import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        Get.snackbar("Coming Soon", "QR customization will be available soon.");
      },

      onContinue: () {
        if (controller.urlController.text.trim().isEmpty) {
          Get.snackbar("Empty URL", "Please enter a URL.");
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
