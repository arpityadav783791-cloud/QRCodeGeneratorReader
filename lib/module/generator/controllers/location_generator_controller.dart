import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationGeneratorController extends GetxController {
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();

  final qrData = ''.obs;

  void generateQR() {
    qrData.value = 'geo:${latitudeController.text},${longitudeController.text}';
  }

  void clear() {
    latitudeController.clear();
    longitudeController.clear();
    qrData.value = '';
  }

  @override
  void onClose() {
    latitudeController.dispose();
    longitudeController.dispose();
    super.onClose();
  }
}
