import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_generator_reader/module/history/services/history_service.dart';

class ContactGeneratorController extends GetxController {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final companyController = TextEditingController();
  final websiteController = TextEditingController();
  final addressController = TextEditingController();
  final HistoryService historyService = Get.find<HistoryService>();

  final qrData = ''.obs;

  void generateQR() async{
    qrData.value =
        '''
          BEGIN:VCARD
          VERSION:3.0
          FN:${nameController.text}
          TEL:${phoneController.text}
          EMAIL:${emailController.text}
          ORG:${companyController.text}
          URL:${websiteController.text}
          ADR:${addressController.text}
          END:VCARD
        ''';

        await historyService.addGeneratedHistory(
          content: qrData.value,
          type: 'contact',
        );
  }

  void clear() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    companyController.clear();
    websiteController.clear();
    addressController.clear();
    qrData.value = '';
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    companyController.dispose();
    websiteController.dispose();
    addressController.dispose();
    super.onClose();
  }
}
