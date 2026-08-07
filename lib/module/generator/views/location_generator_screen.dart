import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_generator_reader/app/routes/app_routes.dart';

import '../controllers/location_generator_controller.dart';
import '../widgets/base_generator_screen.dart';
import '../widgets/generator_input_field.dart';

class LocationGeneratorScreen extends GetView<LocationGeneratorController> {
  const LocationGeneratorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseGeneratorScreen(
      title: "Location",

      qrData: controller.qrData,

      onClear: controller.clear,

      onCustomize: () {
        Get.snackbar("Coming Soon", "QR customization will be available soon.");
      },

      onContinue: () {
        if (controller.latitudeController.text.trim().isEmpty ||
            controller.longitudeController.text.trim().isEmpty) {
          Get.snackbar(
            "Missing Coordinates",
            "Please enter both latitude and longitude.",
          );
          return;
        }

        controller.generateQR();

        Get.toNamed(AppRoutes.qrPreview, arguments: controller.qrData.value);
      },

      inputFields: [
        GeneratorInputField(
          controller: controller.latitudeController,
          hintText: "Latitude",
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
            signed: true,
          ),
          onChanged: (_) => controller.generateQR(),
        ),

        const SizedBox(height: 16),

        GeneratorInputField(
          controller: controller.longitudeController,
          hintText: "Longitude",
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
            signed: true,
          ),
          onChanged: (_) => controller.generateQR(),
        ),

        const SizedBox(height: 16),

        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              Get.snackbar(
                "Coming Soon",
                "Current location support will be added soon.",
              );
            },
            icon: const Icon(Icons.my_location),
            label: const Text("Use Current Location"),
          ),
        ),
      ],
    );
  }
}
