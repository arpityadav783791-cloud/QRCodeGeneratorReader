import 'package:get/get.dart';
import 'package:qr_code_generator_reader/module/settings/controllers/notification_controller.dart';

class NotificationBinding extends Bindings{
  @override 
  void dependencies(){
    Get.lazyPut(() => NotificationController(),);
  }
}