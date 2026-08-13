import 'package:get/get.dart';
import 'package:qr_code_generator_reader/module/shared/services/qr_action_service.dart';

import '../controllers/qr_preview_controller.dart';

class QRPreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QRPreviewController>(() => QRPreviewController());

    Get.lazyPut<QRActionService>(() => QRActionService(), fenix: true);
  }
}
