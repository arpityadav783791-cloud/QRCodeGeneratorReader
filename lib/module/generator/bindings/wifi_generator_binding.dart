import 'package:get/get.dart';

import '../controllers/wifi_generator_controller.dart';

class WifiGeneratorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WifiGeneratorController>(() => WifiGeneratorController());
  }
}

