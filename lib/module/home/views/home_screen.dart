import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_generator_reader/app/routes/app_routes.dart';
import 'package:qr_code_generator_reader/module/history/controllers/history_controller.dart';
import 'package:qr_code_generator_reader/module/settings/views/setting_screen.dart';

import '../controllers/home_controller.dart';

import '../../generator/views/generator_screen.dart';
import '../../history/views/history_screen.dart';


class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = const [
      HomeDashboard(),
      GeneratorScreen(),
      HistoryScreen(),
      SettingsScreen(),
    ];

    return Obx(
      () => Scaffold(
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
    );
  }
}

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Get.find<HomeController>().changeTab(1);
                },
              ),
            ),

            const SizedBox(height: 32),

            const Text(
              "Recent Activity",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Card(
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
                      "Your scanned and generated\nQR codes will appear here.",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
