import 'package:get/get.dart';
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

  Future<bool> callPhone(String value) async {
    String phoneNumber = value;
    if(phoneNumber.startsWith('tel:')){
      phoneNumber = phoneNumber.substring(4);
    }
    final uri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    return await launchUrl(uri);
  }

  Future<bool> sendEmail(String value) async{
    String email;
    if(value.startsWith('mailto:')){
      final uri = Uri.tryParse(value);

      if(uri == null ||  uri.path.isEmpty) {
        return false;
      }
      email = uri.path;
    }else{
      final match = RegExp(
        r'[\w.+-]+@[\w-]+\.[\w.-]+',
      ).firstMatch(value);

      if(match == null){
        return false;
      }

      email = match.group(0)!;
    }
    final  uri = Uri(
      scheme: 'mailto',
      path: email,
    );
    return await launchUrl(uri);
  }
  Future<bool> sendSms(String value) async {
    String phoneNumber = '';
    String message = '';

    if (value.startsWith('SMSTO:')) {
      final data = value.substring(6);
      final parts = data.split(':');

      if (parts.isEmpty) {
        return false;
      }

      phoneNumber = parts[0];

      if (parts.length > 1) {
        message = parts.sublist(1).join(':');
      }
    } else if (value.startsWith('sms:')) {
      final uri = Uri.tryParse(value);

      if (uri == null) {
        return false;
      }

      phoneNumber = uri.path;
      message = uri.queryParameters['body'] ?? '';
    }

    if (phoneNumber.isEmpty) {
      return false;
    }

    final uri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: message.isEmpty ? null : {'body': message},
    );

    return await launchUrl(uri);
  }

  Future<bool> openLocation(String value) async {
    if (!value.startsWith('geo:')) {
      return false;
    }

    final location = value.substring(4);

    final coordinates = location.split(',');

    if (coordinates.length < 2) {
      return false;
    }

    final latitude = double.tryParse(coordinates[0].trim());

    final longitude = double.tryParse(coordinates[1].trim());

    if (latitude == null || longitude == null) {
      return false;
    }

    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1'
      '&query=$latitude,$longitude',
    );

    return await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
