import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UrlGeneratorController extends GetxController {
  final urlController = TextEditingController();

  final qrData = ''.obs;

  void updateQR(String value) {
    qrData.value = value.trim();
  }

  void clear() {
    urlController.clear();
    qrData.value = '';
  }

  @override
  void onClose() {
    urlController.dispose();
    super.onClose();
  }
}
