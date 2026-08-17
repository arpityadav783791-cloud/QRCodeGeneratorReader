import '../../scanner/controllers/scan_result_type.dart';
import 'qr_action_type.dart';

class QRContextAction {
  final QRActionType action;
  final ScanResultType context;

  const QRContextAction({required this.action, required this.context});
}

QRContextAction? getQRContextAction(ScanResultType type) {
  switch (type) {
    case ScanResultType.payment:
      return const QRContextAction(
        context: ScanResultType.payment,
        action: QRActionType.pay,
      );

    case ScanResultType.phone:
      return const QRContextAction(
        context: ScanResultType.phone,
        action: QRActionType.call,
      );

    case ScanResultType.sms:
      return const QRContextAction(
        context: ScanResultType.sms,
        action: QRActionType.sendSms,
      );

    case ScanResultType.url:
      return const QRContextAction(
        context: ScanResultType.url,
        action: QRActionType.openLink,
      );

    case ScanResultType.email:
      return const QRContextAction(
        context: ScanResultType.email,
        action: QRActionType.sendEmail,
      );

    case ScanResultType.location:
      return const QRContextAction(
        context: ScanResultType.location,
        action: QRActionType.openMaps,
      );

    case ScanResultType.text:
      return null;
  }
}
