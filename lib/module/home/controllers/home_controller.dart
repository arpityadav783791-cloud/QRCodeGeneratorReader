import 'package:get/get.dart';
import 'package:qr_code_generator_reader/module/history/services/history_service.dart';

class HomeController extends GetxController {
  final currentIndex = 0.obs;

  final HistoryService historyService = Get.find<HistoryService>();

  void changeTab(int index) {
    currentIndex.value = index;
  }
}
