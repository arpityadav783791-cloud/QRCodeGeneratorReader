import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:qr_code_generator_reader/module/shared/services/qr_action_service.dart';


class QRPreviewController extends GetxController{
  final qrData = ''.obs;
  final QRActionService qrActionService = Get.find<QRActionService>();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      qrData.value = Get.arguments as String;
    }
  }

  Future<void> downloadQR(GlobalKey qrKey) async {
    await qrActionService.downloadQR(
      qrKey: qrKey, 
      content: qrData.value
    );
  }

  Future<void> shareQR(GlobalKey qrKey) async {
    await qrActionService.shareQR(qrKey: qrKey, content: qrData.value);
  }

  Future<void> copyQR() async {
    await qrActionService.copyQR(qrData.value);
  }

  Future<void> saveQR(GlobalKey qrKey) async {
    await qrActionService.saveQR(qrKey: qrKey, content: qrData.value);
  }
  
  void printQR() {}
}