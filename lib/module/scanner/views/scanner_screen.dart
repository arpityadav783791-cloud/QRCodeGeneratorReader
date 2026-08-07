import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:qr_code_generator_reader/app/theme/app_colors.dart';
import 'package:qr_code_generator_reader/app/theme/app_text_styles.dart';
import '../controllers/scanner_controller.dart';

class ScannerScreen extends GetView<ScannerController> {
  const ScannerScreen({super.key});

  @override   
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Scan QR Code",
          style: AppTextStyles.headingMedium,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: const Center(
                  child: Text(
                    "Camera Preview\n(Coming Soon)",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,

              ),
              child:  Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: controller.pickImage,
                      icon: const Icon(Icons.photo_library),
                      label: const Text("Gallery"),
                    ),
                  ),
                  const SizedBox(width: 16,),
                  Expanded(
                    child: Obx(
                      () => ElevatedButton.icon(
                        onPressed: controller.toggleFlash,
                        icon: Icon(
                          controller.isFlashOn.value? Icons.flash_on:Icons.flash_off,
                        ),
                        label: const Text("Flash"),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
