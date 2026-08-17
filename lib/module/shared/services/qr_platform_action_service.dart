import 'package:url_launcher/url_launcher.dart';

class QRPlatformActionService {
  Future<bool> openUrl(String value) async {
    final uri = Uri.tryParse(value);

    if (uri == null) {
      return false;
    }

    return await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<bool> callPhone(String value) async {
    String phoneNumber = value;

    if (phoneNumber.startsWith('tel:')) {
      phoneNumber = phoneNumber.substring(4);
    }

    final uri = Uri(scheme: 'tel', path: phoneNumber);

    return await launchUrl(uri);
  }

  Future<bool> sendEmail(String value) async {
    String email;

    if (value.startsWith('mailto:')) {
      final uri = Uri.tryParse(value);

      if (uri == null || uri.path.isEmpty) {
        return false;
      }

      email = uri.path;
    } else {
      final match = RegExp(r'[\w.+-]+@[\w-]+\.[\w.-]+').firstMatch(value);

      if (match == null) {
        return false;
      }

      email = match.group(0)!;
    }

    final uri = Uri(scheme: 'mailto', path: email);

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

  Future<bool> payWithUpi(String value) async {
    final uri = Uri.tryParse(value);

    if (uri == null) {
      return false;
    }

    if (uri.scheme.toLowerCase() != 'upi') {
      return false;
    }

    if (uri.host.toLowerCase() != 'pay') {
      return false;
    }

    final payeeAddress = uri.queryParameters['pa'];

    if (payeeAddress == null || payeeAddress.isEmpty) {
      return false;
    }

    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      return false;
    }
  }
}
