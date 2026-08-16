import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class LocationGeneratorController extends GetxController {
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();

  final qrData = ''.obs;

  final isGettingLocation = false.obs;

  Future<void> useCurrentLocation() async {
    try {
      isGettingLocation.value = true;

      // 1. Check whether location service is enabled.
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        Get.snackbar(
          'Location Disabled',
          'Please turn on Location/GPS on your device.',
        );
        return;
      }

      // 2. Check permission.
      LocationPermission permission = await Geolocator.checkPermission();

      // 3. Request permission if needed.
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      // 4. Permission still denied.
      if (permission == LocationPermission.denied) {
        Get.snackbar('Permission Denied', 'Location permission was denied.');
        return;
      }

      // 5. Permission permanently denied.
      if (permission == LocationPermission.deniedForever) {
        Get.snackbar(
          'Permission Required',
          'Please allow location permission from app settings.',
        );

        await Geolocator.openAppSettings();
        return;
      }

      // 6. Get current position.
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      // 7. Put coordinates into the fields.
      latitudeController.text = position.latitude.toString();
      longitudeController.text = position.longitude.toString();

      // 8. Update QR data.
      generateQR();

      Get.snackbar('Location Found', 'Current location added successfully.');
    } catch (e) {
      Get.snackbar('Location Error', e.toString());
    } finally {
      isGettingLocation.value = false;
    }
  }

  void generateQR() {
    qrData.value = 'geo:${latitudeController.text},${longitudeController.text}';
  }

  void clear() {
    latitudeController.clear();
    longitudeController.clear();
    qrData.value = '';
  }

  @override
  void onClose() {
    latitudeController.dispose();
    longitudeController.dispose();
    super.onClose();
  }
}
