import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:qr_code_generator_reader/module/generator/controllers/generator_controller.dart';

import 'package:qr_code_generator_reader/module/generator/widgets/qr_type_card.dart';

class GeneratorScreen extends GetView<GeneratorController> {
  const GeneratorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Generator",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.filter_alt_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Type',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 18,),

             GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.qrTypes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.92,
                ),
                itemBuilder: (context, index) {
                  final item = controller.qrTypes[index];

                  return QRTypeCard(
                    title: item.title,
                    icon: item.icon,
                    onTap: () => Get.toNamed(item.route),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}