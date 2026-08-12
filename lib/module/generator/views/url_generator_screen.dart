import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_generator_reader/app/utils/app_snackbar.dart';
import 'package:qr_code_generator_reader/module/history/services/history_service.dart';

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

      onContinue: () async{
        if (controller.urlController.text.trim().isEmpty) {
          AppSnackbar.show(
            title: "Empty URL", 
            message: "Please enter a URL."
          );
          return;
        }
        await Get.find<HistoryService>().addGeneratedHistory(
          content: controller.qrData.value,
          type: 'url',
        );

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
