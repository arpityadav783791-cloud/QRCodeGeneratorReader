import 'package:get/get.dart';
import 'package:qr_code_generator_reader/module/generator/controllers/generator_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());

    Get.lazyPut<GeneratorController>(() => GeneratorController()
    );
  }
}
