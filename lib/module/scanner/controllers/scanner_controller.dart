import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_generator_reader/app/utils/app_snackbar.dart';
import 'package:qr_code_generator_reader/module/scanner/controllers/scan_result_type.dart';

import '../../../app/routes/app_routes.dart';
import '../services/scanner_service.dart';

class ScannerController extends GetxController {
  final ScannerService scannerService = Get.find<ScannerService>();

  final scannedValue = ''.obs;
  final resultType = ScanResultType.text.obs;

  final isFlashOn = false.obs;

  final hasScanned = false.obs;

  Future<void> toggleFlash() async {
    await scannerService.toggleFlash();

    isFlashOn.toggle();
  }

  Future<void> pickImage() async {
    // Step 1: Gallery open karo
    final image = await scannerService.pickImage();

    // User ne cancel kar diya
    if (image == null) {
      return;
    }

    // Step 2: Selected image ko scan karo
    final result = await scannerService.scanImage(image.path);

    // Step 3: QR nahi mila
    if (result == null || result.barcodes.isEmpty) {
      AppSnackbar.show(
        title: "No QR Code",
        message: "No QR code was found in the selected image.",
      );

      return;
    }

    // Step 4: QR ka actual data nikalo
    final value = result.barcodes.first.rawValue;

    // QR mila but data empty hai
    if (value == null || value.trim().isEmpty) {
      AppSnackbar.show(
        title: "Invalid QR Code",
        message: "Could not read the QR code.",
      );

      return;
    }

    // Step 5: Result save karo
    scannedValue.value = value;
    resultType.value = detectResultType(value);

    // Step 6: Result screen open karo
    Get.toNamed(AppRoutes.scanResult);
  }

  void onDetect(BarcodeCapture capture) {
    if (hasScanned.value) {
      return;
    }

    if (capture.barcodes.isEmpty) {
      return;
    }

    final value = capture.barcodes.first.rawValue;

    if (value == null || value.trim().isEmpty) {
      return;
    }

    hasScanned.value = true;

    scannedValue.value = value;
    resultType.value = detectResultType(value);

    scannerService.controller.stop();

    Get.toNamed(AppRoutes.scanResult)?.then((_) {
      hasScanned.value = false;
    });
  }

  @override
  void onClose() {
    scannerService.dispose();

    super.onClose();
  }

  ScanResultType detectResultType(String value){
    final data = value.trim();
    if(data.startsWith('http://') || data.startsWith('https://')){
      return ScanResultType.url;
    }
    if(data.startsWith('tel:')){
      return ScanResultType.phone;
    }
    if(data.startsWith('mailto:')){
      return ScanResultType.email;
    }
    if(data.startsWith("SMSTO:")||data.startsWith('sms')){
      return ScanResultType.sms;
    }
    if(data.startsWith('geo:')){
      return ScanResultType.location;
    }

    return ScanResultType.text;
  }

  Future<void> openScannedUrl()async{
    final value = scannedValue.value;
    if(value.isEmpty){
      return;
    }
    final opened = await scannerService.openUrl(value);

    if(!opened){
      AppSnackbar.show(
        title: 'Unable to open',
        message: "Counld not open this link",
      );
    }
  }
}
