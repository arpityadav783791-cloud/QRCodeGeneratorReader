import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextGeneratorController extends GetxController{
  final TextEditingController textController = TextEditingController();
  final RxString qrData = "QR Vault".obs;
  bool get hasText => textController.text.trim().isNotEmpty;

  void updateQR(String value){
    qrData.value = value.trim().isEmpty ? 'QR Vault' :value.trim();
  }
  void clear(){
    textController.clear();
    qrData.value  = "QR Vault";
  }

  @override
  void onClose(){
    textController.dispose();
    super.onClose();
  }
}