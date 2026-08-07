import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';


class ScannerService{

  final MobileScannerController controller = MobileScannerController(
    autoStart: false,
    detectionSpeed: DetectionSpeed.normal,
  );
  final ImagePicker _picker = ImagePicker();
  Future<bool> RequestCameraPermission()async{
    final status = await Permission.camera.request();
    return status.isGranted;
  }
  Future<void> startCamera()async{
    await controller.start();
  }
  Future<void> stopCamera()async{
    await controller.stop();
  }

  Future<void> toggleFlash() async{
    await controller.toggleTorch();
  }

  Future<XFile?> pickImage() async{
    return await _picker.pickImage(
      source: ImageSource.gallery,
    );
  }

  void dispose(){
    controller.dispose();
  }

  Future<void> scanImage() async{}
}