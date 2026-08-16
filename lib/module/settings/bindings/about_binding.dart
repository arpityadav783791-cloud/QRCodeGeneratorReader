import 'package:get/get.dart';
import 'package:qr_code_generator_reader/module/settings/controllers/about_controller.dart';

class AboutBinding extends Bindings{
  @override   
  void dependencies(){
    Get.lazyPut(() => AboutController());
  }
}