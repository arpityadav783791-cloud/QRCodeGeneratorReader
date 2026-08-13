import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/history_detail_controller.dart';

class HistoryDetailScreen extends GetView<HistoryDetailController> {
  const HistoryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey qrKey = GlobalKey();
    return Scaffold(
      appBar: AppBar(title: const Text('History Details'), centerTitle: true),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // QR
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: RepaintBoundary(
                  key: qrKey,
                  child: QrImageView(
                    data: controller.item.content,
                    size: 260,
                    version: QrVersions.auto,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Source + Type
              Row(
                children: [
                  Chip(label: Text(controller.sourceLabel)),

                  const SizedBox(width: 8),

                  Chip(label: Text(controller.typeLabel)),
                ],
              ),

              const SizedBox(height: 12),

              // Generated / scanned date
              Text(
                _formatDate(controller.item.createdAt),
                style: const TextStyle(fontSize: 14),
              ),

              const SizedBox(height: 24),

              const Text(
                'Content',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: SelectableText(
                  controller.item.content,
                  style: const TextStyle(fontSize: 16),
                ),
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        controller.downloadQR(qrKey);
                      },
                      icon: const Icon(Icons.download),
                      label: const Text('Download'),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        controller.shareQR(qrKey);
                      },
                      icon: const Icon(Icons.share),
                      label: const Text('Share'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year} "
        "${date.hour.toString().padLeft(2, '0')}:"
        "${date.minute.toString().padLeft(2, '0')}";
  }
}
