import 'package:get/get.dart';
import 'package:qr_code_generator_reader/module/generator/controllers/email_generator_controller.dart';

class EmailGeneratorBinding extends Bindings{
  @override  
  void dependencies(){
    Get.lazyPut<EmailGeneratorController>(
      () => EmailGeneratorController(),
    );
  }
}