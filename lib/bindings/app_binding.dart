import 'package:get/get.dart';
import 'package:qr_code_generator_reader/module/history/services/history_service.dart';

class AppBinding extends Bindings{
  @override   
  void dependencies(){
    Get.putAsync<HistoryService>(
      () => HistoryService().init(),
      permanent: true,
    );
  }
}