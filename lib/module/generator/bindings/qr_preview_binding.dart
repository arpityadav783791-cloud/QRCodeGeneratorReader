import 'package:get/get.dart';

import '../controllers/qr_preview_controller.dart';

class QRPreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QRPreviewController>(() => QRPreviewController());
  }
}
