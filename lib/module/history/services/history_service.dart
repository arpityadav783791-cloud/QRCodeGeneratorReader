import 'dart:convert';
import 'package:get/get.dart';
import 'package:qr_code_generator_reader/module/history/models/history_item.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HistoryService extends GetxService{
  static const  String _historyKey = 'qr_history';
  late SharedPreferences _preferences;

  Future<HistoryService> init() async{
    _preferences = await SharedPreferences.getInstance();
    return this;
  }

  Future<List<HistoryItem>> getHistory() async{
    final data  = _preferences.getStringList(_historyKey)??[];

    return data.map(
      (item) => HistoryItem.fromJson(
        jsonDecode(item) as Map<String, dynamic>,
      ),
    ).toList();
  }

  Future<void> addHistory(HistoryItem item) async{
    final history = await getHistory();

    history.insert(0, item);
    final data = history.map(
      (item) => jsonEncode(item.toJson()),
    ).toList();
    await _preferences.setStringList(_historyKey, data);
  }

  Future<void> deleteHistory(String id) async{
    final history = await getHistory();

    history.removeWhere(
      (item) => item.id == id,
    );

    final data = history.map(
      (item) => jsonEncode(item.toJson()),
    ).toList();

    await _preferences.setStringList(_historyKey, data);
  }

  Future<void> clearHistory() async{
    await _preferences.remove(_historyKey);
  }
}
