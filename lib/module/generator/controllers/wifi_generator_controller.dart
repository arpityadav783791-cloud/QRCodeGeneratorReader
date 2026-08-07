import 'package:flutter/material.dart';
import 'package:get/get.dart';
class WifiGeneratorController extends GetxController{
  final ssidController = TextEditingController();
  final passwordController = TextEditingController();

  final qrData = ''.obs;
  final selectedSecurity = 'WPA'.obs;

  void generateQR() {
    qrData.value =
        'WIFI:T:${selectedSecurity.value};'
        'S:${ssidController.text};'
        'P:${passwordController.text};;';
  }

  void clear() {
    ssidController.clear();
    passwordController.clear();
    selectedSecurity.value = 'WPA';
    qrData.value = '';
  }

  @override   
  void onClose(){
    ssidController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}