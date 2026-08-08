import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackbar {
  AppSnackbar._();

  static void show({
    required String title,
    required String message,
  }){
    if(Get.isSnackbarOpen){
      Get.closeCurrentSnackbar();
    }

    // show new snackbar immmediately..
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      animationDuration: const Duration(milliseconds: 200),
    );
  }
}