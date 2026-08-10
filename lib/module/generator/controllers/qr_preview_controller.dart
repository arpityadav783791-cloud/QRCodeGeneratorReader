import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:share_plus/share_plus.dart';
class QRPreviewController extends GetxController{
  final qrData = ''.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      qrData.value = Get.arguments as String;
    }
  }

  Future<void> downloadQR(GlobalKey qrKey) async {
    try {
      final boundary =
          qrKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

      if (boundary == null) {
        return;
      }

      final image = await boundary.toImage(pixelRatio: 3.0);

      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        return;
      }

      final fileName = generateFileName();

      final directory = Directory('/storage/emulated/0/Download');

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      final file = File('${directory.path}/$fileName');

      await file.writeAsBytes(byteData.buffer.asUint8List());

      Get.snackbar("Downloaded", "Path: ${file.path}");
    } catch (e) {
      Get.snackbar("Download Failed", "Could not save QR code.");
    }
  }

  void shareQR() async{
    if(qrData.value.isEmpty){
      return;
    }
    await SharePlus.instance.share(
      ShareParams(
        text: qrData.value,
      ),
    );
  }

  void copyQR() async{
    if(qrData.value.isEmpty){
      return;
    }
    await Clipboard.setData(
      ClipboardData(text: qrData.value),
    );
  }
  void saveQR() {}
  void printQR() {}

  String generateFileName() {
    String name = qrData.value.trim();

    if (name.isEmpty) {
      return 'qr_code.png';
    }

    // Remove characters that are not safe for file names.
    name = name.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');

    // Replace multiple spaces with a single underscore.
    name = name.replaceAll(RegExp(r'\s+'), '_');

    // Remove extra underscores from the beginning/end.
    name = name.replaceAll(RegExp(r'^_+|_+$'), '');

    // Keep the filename reasonably short.
    if (name.length > 50) {
      name = name.substring(0, 50);
    }

    if (name.isEmpty) {
      name = 'qr_code';
    }

    return '$name.png';
  }

}