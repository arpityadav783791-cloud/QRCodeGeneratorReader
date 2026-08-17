import 'dart:convert';
import 'package:get/get.dart';
import 'package:qr_code_generator_reader/module/history/models/history_item.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HistoryService extends GetxService{
  static const  String _historyKey = 'qr_history';
  late SharedPreferences _preferences;
  final history = <HistoryItem>[].obs;

  Future<HistoryService> init() async {
    _preferences = await SharedPreferences.getInstance();

    await loadHistory();

    return this;
  }

  Future<void> loadHistory() async {
    final data = _preferences.getStringList(_historyKey) ?? [];

    final loadedHistory = data
        .map(
          (item) =>
              HistoryItem.fromJson(jsonDecode(item) as Map<String, dynamic>),
        )
        .toList();

    history.value = loadedHistory;
  }

  Future<List<HistoryItem>> getHistory() async {
    final data = _preferences.getStringList(_historyKey) ?? [];

    final history = data
        .map(
          (item) =>
              HistoryItem.fromJson(jsonDecode(item) as Map<String, dynamic>),
        )
        .toList();

    final uniqueHistory = <HistoryItem>[];
    final seen = <String>{};

    for (final item in history) {
      final key = '${item.source}|${item.content}';

      if (seen.contains(key)) {
        continue;
      }

      seen.add(key);
      uniqueHistory.add(item);
    }

    if (uniqueHistory.length != history.length) {
      final cleanedData = uniqueHistory
          .map((item) => jsonEncode(item.toJson()))
          .toList();

      await _preferences.setStringList(_historyKey, cleanedData);
    }

    return uniqueHistory;
  }

  Future<void> addHistory(HistoryItem item) async {
    final existingHistory = await getHistory();

    final alreadyExists = existingHistory.any(
      (existingItem) =>
          existingItem.source == item.source &&
          existingItem.content == item.content,
    );

    if (alreadyExists) {
      return;
    }

    existingHistory.insert(0, item);

    final data = existingHistory
        .map((item) => jsonEncode(item.toJson()))
        .toList();

    await _preferences.setStringList(_historyKey, data);

    history.value = existingHistory;
  }

  Future<void> deleteHistory(String id) async {
    final existingHistory = await getHistory();

    existingHistory.removeWhere((item) => item.id == id);

    final data = existingHistory
        .map((item) => jsonEncode(item.toJson()))
        .toList();

    await _preferences.setStringList(_historyKey, data);

    history.value = existingHistory;
  }

  Future<void> clearHistory() async {
    await _preferences.remove(_historyKey);

    history.clear();
  }

  Future<void> addGeneratedHistory({
    required String content,
    required String type,
  }) async {
    final history = await getHistory();

    final alreadyExists = history.any(
      (item) =>
          item.source == 'generated' &&
          item.type == type &&
          item.content == content,
    );

    if (alreadyExists) {
      return;
    }

    final item = HistoryItem(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      content: content,
      type: type,
      source: 'generated',
      createdAt: DateTime.now(),
    );

    await addHistory(item);
  }
}
