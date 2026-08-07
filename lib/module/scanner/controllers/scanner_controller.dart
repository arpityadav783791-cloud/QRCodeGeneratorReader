import 'package:get/get.dart';
import 'package:qr_code_generator_reader/module/scanner/services/scanner_service.dart';

class ScannerController extends GetxController {
  final ScannerService _scannerService = Get.find<ScannerService>();
  final scannedValue = ''.obs;
  final isFlashOn = false.obs;
  final isScanning = true.obs;

  void stopCamera(){
    _scannerService.stopCamera();
  }

  void toggleFlash(){
    isFlashOn.toggle();
    _scannerService.toggleFlash();
  }

  void pickImage(){
    _scannerService.pickImage();
  }

  void onDetect(String value){
    scannedValue.value = value;
  }
}
