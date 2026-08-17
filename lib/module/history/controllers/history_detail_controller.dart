import 'package:get/get.dart';
import 'package:qr_code_generator_reader/module/shared/services/qr_action_executor.dart';
import '../models/history_item.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_code_generator_reader/module/shared/services/qr_action_service.dart';
import 'package:qr_code_generator_reader/module/scanner/services/qr_type_detector.dart';
import 'package:qr_code_generator_reader/module/shared/models/qr_context_action.dart';

class HistoryDetailController extends GetxController {
  late final HistoryItem item;
  final QRActionService qrActionService = Get.find<QRActionService>();

  @override
  void onInit() {
    super.onInit();

    item = Get.arguments as HistoryItem;
  }

  String get sourceLabel {
    return item.source == 'generated' ? 'Generated' : 'Scanned';
  }

  String get typeLabel {
    if (item.type.isEmpty) {
      return 'QR Code';
    }

    return item.type[0].toUpperCase() + item.type.substring(1);
  }
  Future<void> downloadQR(GlobalKey qrKey) async {
    await qrActionService.downloadQR(qrKey: qrKey, content: item.content);
  }

  Future<void> shareQR(GlobalKey qrKey) async {
    await qrActionService.shareQR(qrKey: qrKey, content: item.content);
  }

  Future<void> copyQR() async {
    await qrActionService.copyQR(item.content);
  }
  Future<void> saveQR(GlobalKey qrKey) async {
    await qrActionService.saveQR(qrKey: qrKey, content: item.content);
  }
  List<QRContextAction> get contextualActions {
    final types = QRTypeDetector.detect(item.content);

    return types.map(getQRContextAction).whereType<QRContextAction>().toList();
  }
  Future<bool> executeContextualAction(QRContextAction contextAction) async {
    return await QRActionExecutor.execute(
      action: contextAction.action,
      content: item.content,
    );
  }
}
