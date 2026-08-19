import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_generator_reader/app/routes/app_routes.dart';
import 'package:qr_code_generator_reader/module/history/controllers/history_controller.dart';
import 'package:qr_code_generator_reader/module/history/models/history_item.dart';
import 'package:qr_code_generator_reader/module/settings/views/setting_screen.dart';

import '../controllers/home_controller.dart';

import '../../generator/views/generator_screen.dart';
import '../../history/views/history_screen.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeDashboard(),
      const GeneratorScreen(),
      const HistoryScreen(),
      const SettingsScreen(),
    ];

    return Obx(
      () => PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async{
          if(controller.currentIndex.value != 0){
            controller.changeTab(0);
            return ;
          }
          final shouldExit = await Get.dialog<bool>(
            AlertDialog(
              title: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('🥺', style: TextStyle(fontSize: 42)),
                  SizedBox(height: 8),
                  Text('Leaving already?'),
                ],
              ),
              content: const Text(
                'Are you sure you want to exit the application?',
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back(result: false);
                  },
                  child: const Text('Stay'),
                ),
                TextButton(
                  onPressed: () {
                    Get.back(result: true);
                  },
                  child: const Text('Exit'),
                ),
              ],
            ),
          );
          if(shouldExit ==true){
            Get.back();
          }
        },
        child: Scaffold(
          body: pages[controller.currentIndex.value],
        
          bottomNavigationBar: NavigationBar(
            selectedIndex: controller.currentIndex.value,
            onDestinationSelected: (index) {
              controller.changeTab(index);
        
              if (index == 2) {
                Get.find<HistoryController>().loadHistory();
              }
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.qr_code_scanner_outlined),
                selectedIcon: Icon(Icons.qr_code_scanner),
                label: "Scan",
              ),
              NavigationDestination(
                icon: Icon(Icons.qr_code_outlined),
                selectedIcon: Icon(Icons.qr_code),
                label: "Generate",
              ),
              NavigationDestination(
                icon: Icon(Icons.history_outlined),
                selectedIcon: Icon(Icons.history),
                label: "History",
              ),
              NavigationDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: "Settings",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeDashboard extends GetView<HomeController> {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
    
      appBar: AppBar(title: const Text("QR Vault"), centerTitle: true),
    
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
    
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Quick Actions",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
    
            const SizedBox(height: 20),
    
            SizedBox(
              width: double.infinity,
              height: 80,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.qr_code_scanner, size: 30),
                label: const Text(
                  "Scan QR Code",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Get.toNamed(AppRoutes.scanner);
                },
              ),
            ),
    
            const SizedBox(height: 16),
    
            SizedBox(
              width: double.infinity,
              height: 80,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.qr_code, size: 30),
                label: const Text(
                  "Generate QR Code",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  controller.changeTab(1);
                },
              ),
            ),
    
            const SizedBox(height: 32),
    
            const Text(
              "Recent Activity",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
    
            const SizedBox(height: 20),
    
            Obx(() {
              final recentItems = controller.historyService.history
                  .take(3)
                  .toList();
    
              if (recentItems.isEmpty) {
                return Card(
                  child: SizedBox(
                    width: double.infinity,
                    height: 180,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.history, size: 60),
                        SizedBox(height: 12),
                        Text(
                          "No recent QR activity",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "Your scanned and generated\n"
                          "QR codes will appear here.",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }
    
              return Column(
                children: [
                  ...recentItems.map(
                    (item) => _RecentActivityCard(
                      item: item,
                      onTap: () {
                        Get.toNamed(AppRoutes.historyDetail, arguments: item);
                      },
                    ),
                  ),
    
                  const SizedBox(height: 12),
    
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        controller.changeTab(2);
                      },
                      child: const Text("View All History"),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _RecentActivityCard extends StatelessWidget {
  final HistoryItem item;
  final VoidCallback onTap;

  const _RecentActivityCard({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),

      child: ListTile(
        onTap: onTap,

        leading: CircleAvatar(
          backgroundColor: colorScheme.primaryContainer,
          foregroundColor: colorScheme.onPrimaryContainer,
          child: Icon(
            item.source == 'scanned' ? Icons.qr_code_scanner : Icons.qr_code,
          ),
        ),

        title: Text(item.content, maxLines: 1, overflow: TextOverflow.ellipsis),

        subtitle: Text(
          '${item.source} • ${item.type}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
