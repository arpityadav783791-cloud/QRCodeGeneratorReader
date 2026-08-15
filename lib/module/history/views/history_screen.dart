import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_generator_reader/app/routes/app_routes.dart';
import 'package:qr_code_generator_reader/module/history/controllers/history_controller.dart';

class HistoryScreen extends GetView<HistoryController> {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "History",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          Obx(
            (){
              if(controller.history.isEmpty){
                return const SizedBox.shrink();
              }
              return IconButton(
                onPressed: (){
                  Get.dialog(
                    AlertDialog(
                      title: const Text(
                        'Clear History?',
                      ),
                      content: const Text(
                        'Are you sure you want to delete all history entries? '
          'This action cannot be undone.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: (){
                            Get.back();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: (){
                            Get.back();
                            controller.clearAll();
                          },
                          child: const Text('Clear All'),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.delete_outline),
                tooltip: 'Clear History',
              );
            }
          )
        ],
      ),
      body: SafeArea(
        child: Obx(
          (){
            if(controller.isLoading.value){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if(controller.history.isEmpty){
              return const Center(
                child: Text(
                  "No History Yet",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: controller.history.length,
              separatorBuilder: (_,_){
                return const SizedBox(height: 12,);
              },
              itemBuilder: ((context, index) {
                final item = controller.history[index];

                return Card(
                margin: EdgeInsets.zero,
                elevation: 0,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Get.toNamed(AppRoutes.historyDetail, arguments: item);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                          ),
                          child: Icon(_getIcon(item.type)),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getTypeLabel(item.type),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              const SizedBox(height: 5),

                              Text(
                                item.content,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 14),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                "${_getSourceLabel(item.source)} • "
                                "${_formatDate(item.createdAt)}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 8),

                        IconButton(
                          onPressed: () {
                            Get.dialog(
                              AlertDialog(
                                title: const Text("Delete History?"),
                                content: const Text(
                                  "Are you sure you want to delete this history entry?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                      controller.deleteItem(item.id);
                                    },
                                    child: const Text("Delete"),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: const Icon(Icons.delete_outline),
                          tooltip: 'Delete',
                        ),
                      ],
                    ),
                  ),
                ),
              );
              }),
            );
          }
        ),
      ),
    );
  }
  IconData _getIcon(String type) {
    if (type.contains('url')) {
      return Icons.link;
    }

    if (type.contains('phone')) {
      return Icons.phone;
    }

    if (type.contains('email')) {
      return Icons.email_outlined;
    }

    if (type.contains('sms')) {
      return Icons.sms_outlined;
    }

    if (type.contains('location')) {
      return Icons.location_on_outlined;
    }

    if (type.contains('wifi')) {
      return Icons.wifi;
    }

    if (type.contains('contact')) {
      return Icons.contact_page_outlined;
    }

    return Icons.text_fields;
  }

  String _getTypeLabel(String type) {
    if (type.contains('url')) {
      return 'URL';
    }

    if (type.contains('phone')) {
      return 'Phone';
    }

    if (type.contains('email')) {
      return 'Email';
    }

    if (type.contains('sms')) {
      return 'SMS';
    }

    if (type.contains('location')) {
      return 'Location';
    }

    if (type.contains('wifi')) {
      return 'WiFi';
    }

    if (type.contains('contact')) {
      return 'Contact';
    }

    return 'Text';
  }

  String _getSourceLabel(String source) {
    if (source == 'generated') {
      return 'Generated';
    }

    if (source == 'scanned') {
      return 'Scanned';
    }

    return source;
  }

  String _formatDate(DateTime date){
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year} "
        "${date.hour.toString().padLeft(2, '0')}:"
        "${date.minute.toString().padLeft(2, '0')}";
  }
}
