import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_generator_reader/app/theme/app_colors.dart';
import 'package:qr_code_generator_reader/app/theme/app_text_styles.dart';
import 'package:qr_code_generator_reader/module/scanner/widgets/camera_overlay.dart';
import 'package:qr_code_generator_reader/module/scanner/widgets/scanner_bottom_bar.dart';
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
      body: Stack(
        children: [
          MobileScanner(
            controller: controller.scannerService.controller,

            onDetect: (capture){
              controller.onDetect(capture);
            },
          ),
          const CameraOverlay(),
          const ScannerBottomBar(),
        ],
      ),
    );
  }
}
