import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_generator_reader/app/routes/app_routes.dart';
import 'package:qr_code_generator_reader/app/utils/app_snackbar.dart';
import 'package:qr_code_generator_reader/module/generator/controllers/text_generator_controller.dart';
import 'package:qr_code_generator_reader/module/generator/widgets/base_generator_screen.dart';
import 'package:qr_code_generator_reader/module/generator/widgets/generator_input_field.dart';

class TextGeneratorScreen extends GetView<TextGeneratorController>{
  const TextGeneratorScreen({super.key});

  @override
  Widget build(BuildContext context){
    return BaseGeneratorScreen(
      title: 'Text',
      qrData: controller.qrData,
      onClear: controller.clear,
      onCustomize: (){
        AppSnackbar.show(
          title: "Coming Soon",
          message: "QR customization will be available soon. ",
        );
      },
      onContinue: () {
        if (controller.textController.text.trim().isEmpty) {
          AppSnackbar.show(
            title: "Empty Text",
            message: "Please enter some text first.",
          );
          return;
        }

        Get.toNamed(AppRoutes.qrPreview, arguments: controller.qrData.value);
      },
      
      inputFields: [
        GeneratorInputField(
          controller: controller.textController,
          hintText: 'Enter you text...',
          maxLines: 5,
          onChanged: controller.updateQR,
        )
      ],
    );
  }
}