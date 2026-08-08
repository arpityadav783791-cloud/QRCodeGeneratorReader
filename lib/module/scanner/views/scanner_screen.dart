import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

import '../controllers/scanner_controller.dart';
import '../widgets/camera_overlay.dart';
import '../widgets/scanner_bottom_bar.dart';

class ScannerScreen extends GetView<ScannerController> {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text("Scan QR Code", style: AppTextStyles.headingMedium),
      ),

      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: MobileScanner(
                controller: controller.scannerService.controller,
                onDetect: controller.onDetect,
              ),
            ),
        
            const CameraOverlay(),
        
            const ScannerBottomBar(),
          ],
        ),
      ),
    );
  }
}
