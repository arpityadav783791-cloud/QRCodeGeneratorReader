import 'qr_platform_action_service.dart';
import '../models/qr_action_type.dart';

class QRActionExecutor {
  QRActionExecutor._();

  static final QRPlatformActionService _actionService =
      QRPlatformActionService();

  static Future<bool> execute({
    required QRActionType action,
    required String content,
  }) async {
    switch (action) {
      case QRActionType.openLink:
        return await _actionService.openUrl(content);

      case QRActionType.call:
        return await _call(content);

      case QRActionType.sendSms:
        return await _actionService.sendSms(content);

      case QRActionType.sendEmail:
        return await _actionService.sendEmail(content);

      case QRActionType.openMaps:
        return await _actionService.openLocation(content);

      case QRActionType.pay:
        return await _actionService.payWithUpi(content);
    }
  }

  static Future<bool> _call(String content) async {
    String phoneNumber = content.trim();

    if (phoneNumber.toLowerCase().startsWith('upi://')) {
      final uri = Uri.tryParse(phoneNumber);
      final payeeAddress = uri?.queryParameters['pa'];

      if (payeeAddress != null && payeeAddress.isNotEmpty) {
        phoneNumber = payeeAddress.split('@').first;
      }
    }

    return await _actionService.callPhone(phoneNumber);
  }
}