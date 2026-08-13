import 'package:get/get.dart';
import 'package:qr_code_generator_reader/module/history/controllers/history_detail_controller.dart';
import 'package:qr_code_generator_reader/module/shared/services/qr_action_service.dart';

class HistoryDetailBinding extends Bindings{
  @override 
  void dependencies(){
    Get.lazyPut<QRActionService>(() => QRActionService(), fenix: true);

    Get.lazyPut<HistoryDetailController>(()=> HistoryDetailController());
  }
}