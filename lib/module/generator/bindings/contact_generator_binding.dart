import 'package:get/get.dart';

import '../controllers/contact_generator_controller.dart';

class ContactGeneratorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactGeneratorController>(() => ContactGeneratorController());
  }
}
