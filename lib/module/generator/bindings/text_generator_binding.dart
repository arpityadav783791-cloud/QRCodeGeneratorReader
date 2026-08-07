import 'package:get/get.dart';

import '../controllers/text_generator_controller.dart';

class TextGeneratorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TextGeneratorController>(() => TextGeneratorController());
  }
}
