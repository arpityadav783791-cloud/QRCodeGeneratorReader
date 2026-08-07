import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_generator_reader/app/routes/app_routes.dart';
import 'package:qr_code_generator_reader/module/generator/models/qr_type_model.dart';

class GeneratorController extends GetxController {
  final List<QRTypeModel> qrTypes = const [
    QRTypeModel(
      title: 'Text',
      icon: Icons.description_outlined,
      route: AppRoutes.textGenerator,
    ),
    QRTypeModel(
      title: "URL",
      icon: Icons.language,
      route: AppRoutes.urlGenerator,
    ),

    QRTypeModel(
      title: "Email",
      icon: Icons.email_outlined,
      route: AppRoutes.emailGenerator,
    ),

    QRTypeModel(
      title: "Phone",
      icon: Icons.phone_outlined,
      route: AppRoutes.phoneGenerator,
    ),

    QRTypeModel(
      title: "SMS",
      icon: Icons.sms_outlined,
      route: AppRoutes.smsGenerator,
    ),

    QRTypeModel(
      title: "WiFi",
      icon: Icons.wifi,
      route: AppRoutes.wifiGenerator,
    ),

    QRTypeModel(
      title: "Contact",
      icon: Icons.person_outline,
      route: AppRoutes.contactGenerator,
    ),

    QRTypeModel(
      title: "Location",
      icon: Icons.location_on_outlined,
      route: AppRoutes.locationGenerator,
    ),
  ];
}
