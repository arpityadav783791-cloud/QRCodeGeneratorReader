import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneGeneratorController extends GetxController {
  final phoneController = TextEditingController();

  final qrData = ''.obs;

  void updateQR(String value) {
    qrData.value = value.trim();
  }

  void generateQR(){
    qrData.value = 'tel:${phoneController.text}';
  }
  void clear() {
    phoneController.clear();
    qrData.value = '';
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}