import 'package:get/get.dart';
class QRPreviewController extends GetxController{
  final qrData = ''.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      qrData.value = Get.arguments as String;
    }
  }

  void downloadQR() {}
  void shareQR() {}
  void copyQR() {}
  void saveQR() {}
  void printQR() {}

}