import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_generator_reader/app/utils/app_snackbar.dart';

import '../../../app/routes/app_routes.dart';
import '../controllers/contact_generator_controller.dart';
import '../widgets/base_generator_screen.dart';
import '../widgets/generator_input_field.dart';

class ContactGeneratorScreen extends GetView<ContactGeneratorController> {
  const ContactGeneratorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseGeneratorScreen(
      title: "Contact",

      qrData: controller.qrData,

      onClear: controller.clear,

      onCustomize: () {
        AppSnackbar.show(
          title: "Coming Soon",
          message: "QR customization will be available soon.",
        );
      },

      onContinue: () {
        if (controller.nameController.text.trim().isEmpty) {
          AppSnackbar.show(
            title: "Empty Name",
            message: "Please enter contact name.",
          );
          return;
        }

        controller.generateQR();

        Get.toNamed(AppRoutes.qrPreview, arguments: controller.qrData.value);
      },

      inputFields: [
        GeneratorInputField(
          controller: controller.nameController,
          hintText: "Name",
          onChanged: (_) => controller.generateQR(),
        ),

        const SizedBox(height: 16),

        GeneratorInputField(
          controller: controller.phoneController,
          hintText: "Phone",
          keyboardType: TextInputType.phone,
          onChanged: (_) => controller.generateQR(),
        ),

        const SizedBox(height: 16),

        GeneratorInputField(
          controller: controller.emailController,
          hintText: "Email",
          keyboardType: TextInputType.emailAddress,
          onChanged: (_) => controller.generateQR(),
        ),

        const SizedBox(height: 16),

        GeneratorInputField(
          controller: controller.companyController,
          hintText: "Company",
          onChanged: (_) => controller.generateQR(),
        ),

        const SizedBox(height: 16),

        GeneratorInputField(
          controller: controller.websiteController,
          hintText: "Website",
          keyboardType: TextInputType.url,
          onChanged: (_) => controller.generateQR(),
        ),

        const SizedBox(height: 16),

        GeneratorInputField(
          controller: controller.addressController,
          hintText: "Address",
          maxLines: 3,
          onChanged: (_) => controller.generateQR(),
        ),
      ],
    );
  }
}
