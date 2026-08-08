import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class ScannerService {
  final MobileScannerController controller = MobileScannerController();

  final ImagePicker _picker = ImagePicker();

  Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();

    return status.isGranted;
  }

  Future<void> startCamera() async {
    await controller.start();
  }

  Future<void> stopCamera() async {
    await controller.stop();
  }

  Future<void> toggleFlash() async {
    await controller.toggleTorch();
  }

  Future<XFile?> pickImage() async {
    return await _picker.pickImage(source: ImageSource.gallery);
  }

  Future<BarcodeCapture?> scanImage(String path) async {
    return await controller.analyzeImage(path);
  }
  Future<bool>openUrl(String value) async{
    final uri = Uri.tryParse(value);
    if(uri == null){
      return false;
    }
    return await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  void dispose() {
    controller.dispose();
  }
}
