import 'package:get/get.dart';
import 'package:qr_code_generator_reader/app/routes/app_routes.dart';
import 'package:qr_code_generator_reader/module/generator/bindings/generator_binding.dart';
import 'package:qr_code_generator_reader/module/generator/bindings/qr_preview_binding.dart';
import 'package:qr_code_generator_reader/module/generator/bindings/text_generator_binding.dart';
import 'package:qr_code_generator_reader/module/generator/views/generator_screen.dart';

import 'package:qr_code_generator_reader/module/generator/views/qr_preview_screen.dart';
import 'package:qr_code_generator_reader/module/generator/views/text_generator_screen.dart';
import 'package:qr_code_generator_reader/module/home/bindings/home_binding.dart';
import 'package:qr_code_generator_reader/module/home/views/home_screen.dart';
import 'package:qr_code_generator_reader/module/scanner/views/scan_result_screen.dart';
import 'package:qr_code_generator_reader/module/splash/bindings/splash_binding.dart';
import 'package:qr_code_generator_reader/module/splash/views/splash_screen.dart';
import 'package:qr_code_generator_reader/module/generator/bindings/url_generator_binding.dart';
import 'package:qr_code_generator_reader/module/generator/bindings/email_generator_binding.dart';
import 'package:qr_code_generator_reader/module/generator/bindings/phone_generator_binding.dart';
import 'package:qr_code_generator_reader/module/generator/bindings/sms_generator_binding.dart';
import 'package:qr_code_generator_reader/module/generator/bindings/wifi_generator_binding.dart';
import 'package:qr_code_generator_reader/module/generator/bindings/contact_generator_binding.dart';
import 'package:qr_code_generator_reader/module/generator/bindings/location_generator_binding.dart';

import 'package:qr_code_generator_reader/module/generator/views/url_generator_screen.dart';
import 'package:qr_code_generator_reader/module/generator/views/email_generator_screen.dart';
import 'package:qr_code_generator_reader/module/generator/views/phone_generator_screen.dart';
import 'package:qr_code_generator_reader/module/generator/views/sms_generator_screen.dart';
import 'package:qr_code_generator_reader/module/generator/views/wifi_generator_screen.dart';
import 'package:qr_code_generator_reader/module/generator/views/contact_generator_screen.dart';
import 'package:qr_code_generator_reader/module/generator/views/location_generator_screen.dart';

class AppPages {
  AppPages._();
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page:() => const SplashScreen(),
      binding: SplashBinding()
    ),
    GetPage(
      name: AppRoutes.home,
      page:() => const HomeScreen(),
      binding: HomeBinding(),  
    ),
    GetPage(
      name: AppRoutes.generate,
      page: () => const GeneratorScreen(),
      binding: GeneratorBinding(),
    ),
    GetPage(
      name: AppRoutes.textGenerator,
      page: () => const TextGeneratorScreen(),
      binding: TextGeneratorBinding(),
    ),
    GetPage(
      name: AppRoutes.qrPreview,
      page: () => const QRPreviewScreen(),
      binding: QRPreviewBinding(),
    ),
    GetPage(
      name: AppRoutes.urlGenerator,
      page: () => const UrlGeneratorScreen(),
      binding: UrlGeneratorBinding(),
    ),

    GetPage(
      name: AppRoutes.emailGenerator,
      page: () => const EmailGeneratorScreen(),
      binding: EmailGeneratorBinding(),
    ),

    GetPage(
      name: AppRoutes.phoneGenerator,
      page: () => const PhoneGeneratorScreen(),
      binding: PhoneGeneratorBinding(),
    ),

    GetPage(
      name: AppRoutes.smsGenerator,
      page: () => const SmsGeneratorScreen(),
      binding: SmsGeneratorBinding(),
    ),

    GetPage(
      name: AppRoutes.wifiGenerator,
      page: () => const WifiGeneratorScreen(),
      binding: WifiGeneratorBinding(),
    ),

    GetPage(
      name: AppRoutes.contactGenerator,
      page: () => const ContactGeneratorScreen(),
      binding: ContactGeneratorBinding(),
    ),

    GetPage(
      name: AppRoutes.locationGenerator,
      page: () => const LocationGeneratorScreen(),
      binding: LocationGeneratorBinding(),
    ),

    GetPage(
      name: AppRoutes.scanResult,
      page: () => const ScanResultScreen(),
    )
  ];
}