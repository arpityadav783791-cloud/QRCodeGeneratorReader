import 'package:get/get.dart';
import 'package:qr_code_generator_reader/module/history/services/history_service.dart';
import 'package:qr_code_generator_reader/module/settings/controllers/settings_controller.dart';
import 'package:qr_code_generator_reader/module/shared/services/qr_action_service.dart';

class AppBinding extends Bindings{
  @override   
  void dependencies(){
    Get.putAsync<HistoryService>(
      () => HistoryService().init(),
      permanent: true,
    );

    Get.put<QRActionService>(QRActionService(), permanent: true);

    Get.lazyPut<SettingsController>(() => SettingsController(), fenix: true);
  }
}