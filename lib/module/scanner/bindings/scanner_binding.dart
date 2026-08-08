import 'package:get/get.dart';
import 'package:qr_code_generator_reader/module/scanner/services/scanner_service.dart';

import '../controllers/scanner_controller.dart';

class ScannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScannerService>(() => ScannerService());
    Get.lazyPut<ScannerController>(() => ScannerController());
  }
}
