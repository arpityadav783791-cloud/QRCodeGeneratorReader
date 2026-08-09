import 'package:get/get.dart';
import 'package:qr_code_generator_reader/module/history/models/history_item.dart';
import 'package:qr_code_generator_reader/module/history/services/history_service.dart';

class HistoryController extends GetxController {
  final HistoryService historyService = Get.find<HistoryService>();

  final history = <HistoryItem>[].obs;
  final isLoading = false.obs;

  @override  
  void onInit(){
    super.onInit();
    loadHistory();
  }
  Future<void> loadHistory() async{
    isLoading.value = true;
    history.value = await historyService.getHistory();
    isLoading.value = false;
  }
  Future<void> deleteItem(String id) async{
    await historyService.deleteHistory(id);
    history.removeWhere(
      (item) => item.id == id,
    );
  }

  Future<void> clearAll() async {
    await historyService.clearHistory();
    history.clear();
  }
}
