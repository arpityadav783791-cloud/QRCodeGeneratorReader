import 'package:get/get.dart';

import '../controllers/location_generator_controller.dart';

class LocationGeneratorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationGeneratorController>(
      () => LocationGeneratorController(),
    );
  }
}
