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
        child: Column(
          
          children: [

            // Search Button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12,16,4),
              child: TextField(
                onChanged: controller.updateSearch,
                decoration: InputDecoration(
                  hintText: 'Search History...',
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                  suffixIcon: Obx(
                    (){
                      if(controller.searchQuery.value.isEmpty){
                        return const SizedBox.shrink();
                      }
                      return IconButton(
                        onPressed: (){
                          controller.updateSearch('');
                        },
                        icon: const Icon(Icons.clear),
                      );
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  )
                ),
              ),
            ),


            // filter button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
              child: Align(
                alignment: Alignment.centerRight,
                child: Obx(
                  (){
                    final filterCount = (controller.selectedSource.value != 'all'? 1:0)+(controller.selectedType.value != 'all'?1:0);
                    return OutlinedButton.icon(
                      onPressed: () {
                        _showFilterSheet(context);
                      },
                      icon: const Icon(Icons.filter_list),
                      label: Text(
                        filterCount == 0?'Filter' : 'Filter • $filterCount',
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
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
                if(controller.filteredHistory.isEmpty){
                  return const Center(
                    child: Text(
                      "No matching history found",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.filteredHistory.length,
                  separatorBuilder: (_,_){
                    return const SizedBox(height: 12,);
                  },
                  itemBuilder: ((context, index) {
                    final item = controller.filteredHistory[index];
            
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
          ],
        )
      ),
    );
  }
 void _showFilterSheet(BuildContext context) {
    Get.bottomSheet(
      SafeArea(
        top: true,
        bottom: true,
        child: Material(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(24),
          ),
          clipBehavior: Clip.antiAlias,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height*0.85,
            ),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // =========================
                // TITLE
                // =========================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Filter History',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
            
                const SizedBox(height: 20),
            
                // =========================
                // SOURCE
                // =========================
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                  'Source',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
            
                const SizedBox(height: 8),
            
                Obx(() {
                  return Column(
                    children: [
                      RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('All'),
                        value: 'all',
                        groupValue: controller.selectedSource.value,
                        onChanged: (value) {
                          if (value != null) {
                            controller.updateSourceFilter(value);
                          }
                        },
                      ),
            
                      RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Generated'),
                        value: 'generated',
                        groupValue: controller.selectedSource.value,
                        onChanged: (value) {
                          if (value != null) {
                            controller.updateSourceFilter(value);
                          }
                        },
                      ),
            
                      RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Scanned'),
                        value: 'scanned',
                        groupValue: controller.selectedSource.value,
                        onChanged: (value) {
                          if (value != null) {
                            controller.updateSourceFilter(value);
                          }
                        },
                      ),
                    ],
                  );
                }),
            
                const SizedBox(height: 16),
            
                // =========================
                // TYPE
                // =========================
                Text(
                  'Type',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
            
                const SizedBox(height: 8),
            
                Obx(() {
                  return Column(
                    children: [
                      _buildTypeRadio(title: 'All', value: 'all'),
            
                      _buildTypeRadio(title: 'Text', value: 'text'),
            
                      _buildTypeRadio(title: 'URL', value: 'url'),
            
                      _buildTypeRadio(title: 'Email', value: 'email'),
            
                      _buildTypeRadio(title: 'Phone', value: 'phone'),
            
                      _buildTypeRadio(title: 'SMS', value: 'sms'),
            
                      _buildTypeRadio(title: 'WiFi', value: 'wifi'),
            
                      _buildTypeRadio(title: 'Contact', value: 'contact'),
            
                      _buildTypeRadio(title: 'Location', value: 'location'),
                    ],
                  );
                }),
                      ],
                    ),
                  ),
                ),
            
                const SizedBox(height: 20),
            
                // =========================
                // ACTIONS
                // =========================
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          controller.clearFilters();
                          Get.back();
                        },
                        child: const Text('Clear'),
                      ),
                    ),
            
                    const SizedBox(width: 12),
            
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('Apply'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildTypeRadio({required String title, required String value}) {
    return RadioListTile<String>(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      value: value,
      groupValue: controller.selectedType.value,
      onChanged: (value) {
        if (value != null) {
          controller.updateTypeFilter(value);
        }
      },
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
