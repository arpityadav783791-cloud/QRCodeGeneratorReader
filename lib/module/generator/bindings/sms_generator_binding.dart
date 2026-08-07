import 'package:get/get.dart';
import 'package:qr_code_generator_reader/module/generator/controllers/sms_generator_controller.dart';
class SmsGeneratorBinding extends Bindings{
  @override   
  void dependencies(){
    Get.lazyPut(
      () => SmsGeneratorController(),
    );
  }
}