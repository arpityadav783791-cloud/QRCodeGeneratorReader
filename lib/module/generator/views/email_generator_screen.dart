import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../controllers/email_generator_controller.dart';
import '../widgets/base_generator_screen.dart';
import '../widgets/generator_input_field.dart';

class EmailGeneratorScreen extends GetView<EmailGeneratorController> {
  const EmailGeneratorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseGeneratorScreen(
      title: "Email",

      qrData: controller.qrData,

      onClear: controller.clear,

      onCustomize: () {},

      onContinue: () {
        controller.generateQR();

        Get.toNamed(AppRoutes.qrPreview, arguments: controller.qrData.value);
      },

      inputFields: [
        GeneratorInputField(
          controller: controller.emailController,
          hintText: "Email Address",
          keyboardType: TextInputType.emailAddress,
          onChanged: (_) => controller.generateQR(),
        ),

        const SizedBox(height: 16),

        GeneratorInputField(
          controller: controller.subjectController,
          hintText: "Subject (Optional)",
          onChanged: (_) => controller.generateQR(),
        ),

        const SizedBox(height: 16),

        GeneratorInputField(
          controller: controller.messageController,
          hintText: "Message (Optional)",
          maxLines: 4,
          onChanged: (_) => controller.generateQR(),
        ),
      ],
    );
  }
}
