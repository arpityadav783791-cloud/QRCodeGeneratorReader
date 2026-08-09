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
  final detectedTypes = <ScanResultType>[].obs;

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
    detectedTypes.value = detectResultTypes(value);

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
    detectedTypes.value = detectResultTypes(value);

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

  List<ScanResultType> detectResultTypes(String value) {
    final data = value.trim();

    final types = <ScanResultType>[];

    // URL
    if (RegExp(r'https?:\/\/[^\s]+', caseSensitive: false).hasMatch(data)) {
      types.add(ScanResultType.url);
    }

    // Email
    if (RegExp(
      r'[\w.+-]+@[\w-]+\.[\w.-]+',
      caseSensitive: false,
    ).hasMatch(data)) {
      types.add(ScanResultType.email);
    }

    // SMS
    if (RegExp(r'(SMSTO:|sms:)', caseSensitive: false).hasMatch(data)) {
      types.add(ScanResultType.sms);
    }

    // Location
    if (RegExp(
      r'geo:-?\d+(\.\d+)?,-?\d+(\.\d+)?',
      caseSensitive: false,
    ).hasMatch(data)) {
      types.add(ScanResultType.location);
    }

    // Phone
    if (data.startsWith('tel:') ||
        RegExp(r'(?<!\d)\d{10}(?!\d)').hasMatch(data)) {
      types.add(ScanResultType.phone);
    }

    // Nothing special detected
    if (types.isEmpty) {
      types.add(ScanResultType.text);
    }

    return types;
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

  Future<void> callScannedPhone()async{
    final value  = scannedValue.value;

    if(value.isEmpty){
      return ;
    }
    final called = await scannerService.callPhone(value);

    if(!called){
      AppSnackbar.show(
        title: "Unable to Call",
        message: "Could not open the phone dialer.",
      );
    }
  }
  Future<void> sendScannedEmail() async {
    final value = scannedValue.value;

    if (value.isEmpty) {
      return;
    }

    final sent = await scannerService.sendEmail(value);

    if (!sent) {
      AppSnackbar.show(
        title: "Unable to Send Email",
        message: "Could not open the email application.",
      );
    }
  }
  Future<void> sendScannedSms() async {
    final value = scannedValue.value;

    if (value.isEmpty) {
      return;
    }

    final sent = await scannerService.sendSms(value);

    if (!sent) {
      AppSnackbar.show(
        title: "Unable to Send SMS",
        message: "Could not open the messaging application.",
      );
    }
  }
  Future<void> openScannedLocation() async {
    final value = scannedValue.value;

    if (value.isEmpty) {
      return;
    }

    final opened = await scannerService.openLocation(value);

    if (!opened) {
      AppSnackbar.show(
        title: "Unable to Open Location",
        message: "Could not open the map for this location.",
      );
    }
  }
}
