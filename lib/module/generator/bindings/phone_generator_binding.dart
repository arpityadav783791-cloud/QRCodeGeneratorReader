import 'package:get/get.dart';

import '../controllers/phone_generator_controller.dart';

class PhoneGeneratorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhoneGeneratorController>(() => PhoneGeneratorController());
  }
}
