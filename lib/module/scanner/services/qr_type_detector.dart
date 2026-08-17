import 'package:qr_code_generator_reader/module/scanner/controllers/scan_result_type.dart';

class QRTypeDetector {
  QRTypeDetector._();

  static List<ScanResultType> detect(String value) {
    final data = value.trim();

    if (data.isEmpty) {
      return [ScanResultType.text];
    }

    final types = <ScanResultType>[];

    // Payment / UPI
    final isUpi = data.toLowerCase().startsWith('upi://pay');

    if (isUpi) {
      types.add(ScanResultType.payment);
    }

    // URL
    if (RegExp(r'https?:\/\/[^\s]+', caseSensitive: false).hasMatch(data)) {
      types.add(ScanResultType.url);
    }

    // Email
    if (RegExp(
      r'[\w.+-]+@[\w-]+\.[\w.-]+',
      caseSensitive: false,
    ).hasMatch(data)) {
      types.add(ScanResultType.email);
    }

    // SMS
    if (RegExp(r'(SMSTO:|sms:)', caseSensitive: false).hasMatch(data)) {
      types.add(ScanResultType.sms);
    }

    // Location
    if (RegExp(
      r'^geo:-?\d+(\.\d+)?,-?\d+(\.\d+)?',
      caseSensitive: false,
    ).hasMatch(data)) {
      types.add(ScanResultType.location);
    }

    // Phone
    bool isPhone = false;

    if (data.toLowerCase().startsWith('tel:')) {
      isPhone = true;
    }

    if (RegExp(r'(?<!\d)\d{10}(?!\d)').hasMatch(data)) {
      isPhone = true;
    }

    // Phone-based UPI ID
    if (isUpi) {
      final uri = Uri.tryParse(data);
      final payeeAddress = uri?.queryParameters['pa'];

      if (payeeAddress != null && payeeAddress.isNotEmpty) {
        final phonePart = payeeAddress.split('@').first;

        if (RegExp(r'^\d{10}$').hasMatch(phonePart)) {
          isPhone = true;
        }
      }
    }

    if (isPhone) {
      types.add(ScanResultType.phone);
    }

    // Normal text
    if (types.isEmpty) {
      types.add(ScanResultType.text);
    }

    return types;
  }
}
