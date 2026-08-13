import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class QRActionService {
  static const MethodChannel _downloadChannel = MethodChannel(
    'qr_vault/download',
  );

  Future<Uint8List?> _captureQR(GlobalKey qrKey) async {
    final boundary =
        qrKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    if (boundary == null) {
      return null;
    }

    final image = await boundary.toImage(pixelRatio: 3.0);

    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData == null) {
      return null;
    }

    return byteData.buffer.asUint8List();
  }

  Future<void> downloadQR({
    required GlobalKey qrKey,
    required String content,
  }) async {
    try {
      final bytes = await _captureQR(qrKey);

      if (bytes == null) {
        return;
      }

      final fileName = generateFileName(content);

      await _downloadChannel.invokeMethod('saveQrToDownloads', {
        'fileName': fileName,
        'bytes': bytes,
      });

      Get.snackbar('Downloaded', '$fileName saved to Downloads');
    } on PlatformException catch (e) {
      Get.snackbar('Download Failed', e.message ?? 'Could not save QR code.');
    } catch (e) {
      Get.snackbar('Download Failed', 'Could not save QR code.');
    }
  }

  Future<void> shareQR({
    required GlobalKey qrKey,
    required String content,
  }) async {
    try {
      final bytes = await _captureQR(qrKey);

      if (bytes == null) {
        return;
      }

      final fileName = generateFileName(content);

      await SharePlus.instance.share(
        ShareParams(
          files: [XFile.fromData(bytes, name: fileName, mimeType: 'image/png')],
        ),
      );
    } catch (e) {
      Get.snackbar('Share Failed', 'Could not share QR code.');
    }
  }

  Future<void> copyQR(String content) async {
    if (content.trim().isEmpty) {
      return;
    }

    await Clipboard.setData(ClipboardData(text: content));

    Get.snackbar('Copied', 'QR content copied to clipboard');
  }

  String generateFileName(String content) {
    String name = content.trim();

    if (name.isEmpty) {
      return 'qr_code.png';
    }

    name = name.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');

    name = name.replaceAll(RegExp(r'\s+'), '_');

    name = name.replaceAll(RegExp(r'^_+|_+$'), '');

    if (name.length > 50) {
      name = name.substring(0, 50);
    }

    if (name.isEmpty) {
      name = 'qr_code';
    }

    return '$name.png';
  }
  Future<void> saveQR({
    required GlobalKey qrKey,
    required String content,
  }) async {
    try {
      final bytes = await _captureQR(qrKey);

      if (bytes == null) {
        return;
      }

      final fileName = generateFileName(content);

      await _downloadChannel.invokeMethod('saveQrToGallery', {
        'fileName': fileName,
        'bytes': bytes,
      });

      Get.snackbar('Saved', '$fileName saved to QR Vault');
    } on PlatformException catch (e) {
      Get.snackbar('Save Failed', e.message ?? 'Could not save QR code.');
    } catch (e) {
      Get.snackbar('Save Failed', 'Could not save QR code.');
    }
  }
}
