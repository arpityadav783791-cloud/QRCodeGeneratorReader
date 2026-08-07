import 'package:get/get.dart';

import '../controllers/url_generator_controller.dart';

class UrlGeneratorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UrlGeneratorController>(() => UrlGeneratorController());
  }
}
