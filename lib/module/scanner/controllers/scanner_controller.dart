import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_generator_reader/app/routes/app_routes.dart';
import 'package:qr_code_generator_reader/module/scanner/services/scanner_service.dart';

class ScannerController extends GetxController {
  final ScannerService scannerService = Get.find<ScannerService>();
  final scannedValue = ''.obs;
  final isFlashOn = false.obs;
  final isScanning = true.obs;

  @override  
  void onInit(){
    super.onInit();
    startCamera();
  }

  Future<void> startCamera()async{
    final granted = await scannerService.RequestCameraPermission();
    if(!granted) return;
    await scannerService.startCamera();
  }
  Future<void> stopCamera()async{
    await scannerService.stopCamera();
  }

  Future<void> toggleFlash()async{
    isFlashOn.toggle();
    await scannerService.toggleFlash();
  }

  Future<void> pickImage()async{
    final image = await scannerService.pickImage();
    if(image == null) return ;
  }

  final hasScanned = false.obs;
  void onDetect(BarcodeCapture capture) {
    if (hasScanned.value) return;
    final barcode = capture.barcodes.first;
    final value = barcode.rawValue;
    if (value == null || value.isEmpty) return;
    hasScanned.value = true;
    scannedValue.value = value;
    stopCamera();

    Get.toNamed(AppRoutes.scanResult)?.then((_) {
      hasScanned.value = false;

      startCamera();
    });
  }
  @override
  void onClose(){
    scannerService.dispose();
    super.onClose();
  }
}
