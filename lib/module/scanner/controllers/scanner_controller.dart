import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_generator_reader/app/utils/app_snackbar.dart';
import 'package:qr_code_generator_reader/module/history/models/history_item.dart';
import 'package:qr_code_generator_reader/module/history/services/history_service.dart';
import 'package:qr_code_generator_reader/module/scanner/controllers/scan_result_type.dart';
import 'package:qr_code_generator_reader/module/scanner/services/qr_type_detector.dart';
import 'package:qr_code_generator_reader/module/shared/models/qr_action_type.dart';
import 'package:qr_code_generator_reader/module/shared/services/qr_action_executor.dart';

import '../../../app/routes/app_routes.dart';
import '../services/scanner_service.dart';

class ScannerController extends GetxController {
  final ScannerService scannerService = Get.find<ScannerService>();
  final HistoryService historyService = Get.find<HistoryService>();

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
    detectedTypes.value = QRTypeDetector.detect(value);
    await saveScanToHistory();

    // Step 6: Result screen open karo
    Get.toNamed(AppRoutes.scanResult);
  }

  Future<void> onDetect(BarcodeCapture capture) async{
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
    detectedTypes.value = QRTypeDetector.detect(value);
    await saveScanToHistory();

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
  

  Future<void> openScannedUrl() async {
    final value = scannedValue.value;

    if (value.isEmpty) {
      return;
    }

    final opened = await QRActionExecutor.execute(
      action: QRActionType.openLink,
      content: value,
    );

    if (!opened) {
      AppSnackbar.show(
        title: 'Unable to Open',
        message: 'Could not open this link.',
      );
    }
  }

  Future<void> callScannedPhone() async {
    final value = scannedValue.value;

    if (value.isEmpty) {
      return;
    }

    final called = await QRActionExecutor.execute(
      action: QRActionType.call,
      content: value,
    );

    if (!called) {
      AppSnackbar.show(
        title: 'Unable to Call',
        message: 'Could not open the phone dialer.',
      );
    }
  }

  Future<void> sendScannedEmail() async {
    final value = scannedValue.value;

    if (value.isEmpty) {
      return;
    }

    final sent = await QRActionExecutor.execute(
      action: QRActionType.sendEmail,
      content: value,
    );

    if (!sent) {
      AppSnackbar.show(
        title: 'Unable to Send Email',
        message: 'Could not open the email application.',
      );
    }
  }

  Future<void> sendScannedSms() async {
    final value = scannedValue.value;

    if (value.isEmpty) {
      return;
    }

    final sent = await QRActionExecutor.execute(
      action: QRActionType.sendSms,
      content: value,
    );

    if (!sent) {
      AppSnackbar.show(
        title: 'Unable to Send SMS',
        message: 'Could not open the messaging application.',
      );
    }
  }

  Future<void> openScannedLocation() async {
    final value = scannedValue.value;

    if (value.isEmpty) {
      return;
    }

    final opened = await QRActionExecutor.execute(
      action: QRActionType.openMaps,
      content: value,
    );

    if (!opened) {
      AppSnackbar.show(
        title: 'Unable to Open Location',
        message: 'Could not open the map for this location.',
      );
    }
  }

  // payment method
  Future<void> payScannedPayment() async {
    final value = scannedValue.value;

    if (value.isEmpty) {
      return;
    }

    final paid = await QRActionExecutor.execute(
      action: QRActionType.pay,
      content: value,
    );

    if (!paid) {
      AppSnackbar.show(
        title: 'Unable to Pay',
        message: 'Could not open a payment application.',
      );
    }
  }

  Future<void> saveScanToHistory() async{
    final value = scannedValue.value;

    if(value.trim().isEmpty){
      return ;
    }
    final types = detectedTypes.map((type) => type.name).join(', ');
    final item = HistoryItem(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      content: value,
      type: types,
      source: 'scanned',
      createdAt: DateTime.now()
    );

    await historyService.addHistory(item);
  }
}
