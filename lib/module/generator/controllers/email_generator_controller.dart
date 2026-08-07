import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailGeneratorController extends GetxController{
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  final qrData = ''.obs;

  void generateQR() {
    qrData.value =
        'MATMSG:TO:${emailController.text};'
        'SUB:${subjectController.text};'
        'BODY:${messageController.text};;';
  }

  void updateQR(String value){
    qrData.value =
        'MATMSG:TO:${emailController.text};'
        'SUB:${subjectController.text};'
        'BODY:${messageController.text};;';
  }

  void clear() {
    emailController.clear();
    subjectController.clear();
    messageController.clear();
    qrData.value = '';
  }
  
  @override
  void onClose() {
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.onClose();
  }
}