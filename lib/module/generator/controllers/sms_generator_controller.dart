import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SmsGeneratorController extends GetxController {
  final phoneController = TextEditingController();
  final messageController = TextEditingController();

  final qrData = ''.obs;

  void generateQR() {
    qrData.value = "SMSTO:${phoneController.text}:${messageController.text}";
  }

  void clear(){
    phoneController.clear();
    messageController.clear();
    qrData.value = '';
  }

  @override
  void onClose() {
    phoneController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
