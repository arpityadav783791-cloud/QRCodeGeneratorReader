import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_generator_reader/app/utils/app_snackbar.dart';
import 'package:qr_code_generator_reader/module/history/services/history_service.dart';

import '../../../app/routes/app_routes.dart';
import '../controllers/phone_generator_controller.dart';
import '../widgets/base_generator_screen.dart';
import '../widgets/generator_input_field.dart';

class PhoneGeneratorScreen extends GetView<PhoneGeneratorController> {
  const PhoneGeneratorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseGeneratorScreen(
      title: "Phone",

      qrData: controller.qrData,

      onClear: controller.clear,

      onCustomize: () {
        AppSnackbar.show(
          title:  "Coming Soon", 
          message: "QR customization will be available soon.");
      },

      onContinue: () async{
        if (controller.phoneController.text.trim().isEmpty) {
          AppSnackbar.show(
            title: "Empty Phone", 
            message: "Please enter a phone number."
            );
          return;
        }

        controller.generateQR();

        await Get.find<HistoryService>().addGeneratedHistory(
          content: controller.qrData.value,
          type: 'email',
        );
        Get.toNamed(AppRoutes.qrPreview, arguments: controller.qrData.value);
      },

      inputFields: [
        GeneratorInputField(
          controller: controller.phoneController,
          hintText: "Enter phone number",
          keyboardType: TextInputType.phone,
          onChanged: (_) => controller.generateQR(),
        ),
      ],
    );
  }
}
