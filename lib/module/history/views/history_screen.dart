import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                onPressed: controller.clearAll,
                icon: const Icon(Icons.delete_outline),
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
                  child: ListTile(
                    leading: Icon(
                      _getIcon(item.type),
                    ),
                    title: Text(
                      item.content,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      "${item.source} • ${_formatDate(item.createdAt)}",
                    ),
                    trailing: IconButton(
                      onPressed: (){
                        controller.deleteItem(item.id);
                      },
                      icon: const Icon(
                        Icons.delete_outline,
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
  IconData _getIcon(String type){
    if(type.contains('url')){
      return Icons.link;
    }
    if(type.contains('phone')){
      return Icons.phone;
    }
    if(type.contains('email')){
      return Icons.email_outlined;
    }
    if (type.contains('sms')) {
      return Icons.sms_outlined;
    }

    if (type.contains('location')) {
      return Icons.location_on_outlined;
    }
    return Icons.text_fields;
  }
  String _formatDate(DateTime date){
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year} "
        "${date.hour.toString().padLeft(2, '0')}:"
        "${date.minute.toString().padLeft(2, '0')}";
  }
}
