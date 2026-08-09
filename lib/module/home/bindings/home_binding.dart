import 'package:get/get.dart';
import 'package:qr_code_generator_reader/module/history/controllers/history_controller.dart';
import 'package:qr_code_generator_reader/module/history/services/history_service.dart';

import '../controllers/home_controller.dart';
import '../../generator/controllers/generator_controller.dart';


class HomeBinding extends Bindings {

 @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());

    Get.lazyPut<GeneratorController>(() => GeneratorController());

    Get.putAsync<HistoryService>(
      () => HistoryService().init(),
      permanent: true,
    );

    Get.lazyPut<HistoryController>(() => HistoryController());
  }
}
