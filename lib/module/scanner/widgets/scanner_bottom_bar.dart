import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:qr_code_generator_reader/app/theme/app_colors.dart';
import 'package:qr_code_generator_reader/module/scanner/controllers/scanner_controller.dart';

class ScannerBottomBar extends GetView<ScannerController>{
  const ScannerBottomBar({super.key});

  @override
  Widget build(BuildContext context){
    return Positioned(
      bottom: 25,
      left: 20,
      right: 20,
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: controller.pickImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              icon: const Icon(Icons.photo_library),
              label: const Text("Gallery"),
            ),
          ),

          const SizedBox(height: 15,),

          Expanded(
            child: Obx(
              () => ElevatedButton.icon(
                onPressed: controller.toggleFlash,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                icon: Icon(
                  controller.isFlashOn.value?Icons.flash_on:Icons.flash_off,
                ),
                label: const Text("Flash"),
              )
            ),
          )
        ],
      ),
    );
  }
}