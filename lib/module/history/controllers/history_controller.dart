import 'package:get/get.dart';
import 'package:qr_code_generator_reader/module/history/models/history_item.dart';
import 'package:qr_code_generator_reader/module/history/services/history_service.dart';

class HistoryController extends GetxController {
  final HistoryService historyService = Get.find<HistoryService>();

  final history = <HistoryItem>[].obs;
  final isLoading = false.obs;

  final searchQuery = ''.obs;
  final selectedSource = 'all'.obs;
  final selectedType = 'all'.obs;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  Future<void> loadHistory() async {
    isLoading.value = true;
    history.value = await historyService.getHistory();
    isLoading.value = false;
  }

  List<HistoryItem> get filteredHistory {
    final query = searchQuery.value.trim().toLowerCase();

    return history.where((item) {
      // Search filter
      final matchesSearch =
          query.isEmpty || item.content.toLowerCase().contains(query);

      // Source filter
      final matchesSource =
          selectedSource.value == 'all' || item.source == selectedSource.value;

      // Type filter
      final matchesType =
          selectedType.value == 'all' ||
          item.type.toLowerCase().contains(selectedType.value.toLowerCase());

      return matchesSearch && matchesSource && matchesType;
    }).toList();
  }

  void updateSearch(String value) {
    searchQuery.value = value;
  }

  void updateSourceFilter(String value) {
    selectedSource.value = value;
  }

  void updateTypeFilter(String value) {
    selectedType.value = value;
  }

  void clearFilters() {
    searchQuery.value = '';
    selectedSource.value = 'all';
    selectedType.value = 'all';
  }

  Future<void> deleteItem(String id) async {
    await historyService.deleteHistory(id);
    history.removeWhere((item) => item.id == id);
  }

  Future<void> clearAll() async {
    await historyService.clearHistory();
    history.clear();
  }
}
