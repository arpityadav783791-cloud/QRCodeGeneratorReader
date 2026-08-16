import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

import 'package:qr_code_generator_reader/app/theme/app_text_styles.dart';
import 'package:qr_code_generator_reader/app/utils/app_snackbar.dart';
import 'package:qr_code_generator_reader/module/scanner/controllers/scan_result_type.dart';
import 'package:qr_code_generator_reader/module/scanner/controllers/scanner_controller.dart';
import 'package:share_plus/share_plus.dart';

class ScanResultScreen extends GetView<ScannerController>{
  const ScanResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScheme.surface,
        centerTitle: true,
        title: Text(
          "Scan Result",
          style: AppTextStyles.headingMedium.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Scanned Content",
                style: AppTextStyles.headingSmall.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 20,),

              Obx(
                () => Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: SelectableText(
                    controller.scannedValue.value.isEmpty?'NO QR Code Scanned':controller.scannedValue.value,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
              const Spacer(),

              Obx(() {
                if (!controller.detectedTypes.contains(ScanResultType.url)) {
                  return const SizedBox.shrink();
                }

                return SizedBox(
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: controller.openScannedUrl,
                    icon: const Icon(Icons.open_in_browser),
                    label: const Text("Open Link"),
                  ),
                );
              }),

              const SizedBox(height: 15,),

              Obx(
                (){
                  if (!controller.detectedTypes.contains(ScanResultType.phone)) {
                    return const SizedBox.shrink();
                  }
                  return SizedBox(
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: controller.callScannedPhone,
                      icon: const Icon(Icons.call),
                      label: const Text("Call"),
                    ),
                  );
                },
              ),

              const SizedBox(height: 15,),

              Obx(
                () {
                  if (!controller.detectedTypes.contains(ScanResultType.email)) {
                    return const SizedBox.shrink();
                  }
                  return SizedBox(
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: controller.sendScannedEmail,
                      icon: const Icon(Icons.email_outlined),
                      label: const Text("Send Email"),
                    ),
                  );
                },
              ),

              const SizedBox(height: 15,),

             Obx(() {
                if (!controller.detectedTypes.contains(ScanResultType.sms)) {
                  return const SizedBox.shrink();
                }

                return SizedBox(
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: controller.sendScannedSms,
                    icon: const Icon(Icons.sms_outlined),
                    label: const Text("Send SMS"),
                  ),
                );
              }),

              const SizedBox(height: 15),

              Obx(() {
                if (!controller.detectedTypes.contains(
                  ScanResultType.location,
                )) {
                  return const SizedBox.shrink();
                }

                return SizedBox(
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: controller.openScannedLocation,
                    icon: const Icon(Icons.location_on_outlined),
                    label: const Text("Open Maps"),
                  ),
                );
              }),

              const SizedBox(height: 15),

              SizedBox(
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: () async{
                    final value = controller.scannedValue.value;

                    if(value.isEmpty){
                      return ;
                    }
                    await Clipboard.setData(
                      ClipboardData(text: value),
                    );

                    AppSnackbar.show(
                      title: 'Copied',
                      message: "QR content copied to clipboard",
                    );
                  },
                  icon: const Icon(Icons.copy),
                  label: const Text("Copy"),
                ),
              ),

              const SizedBox(height: 15,),

              SizedBox(
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: () async{
                    final value = controller.scannedValue.value;

                    if(value.isEmpty){
                      return ;
                    }

                    await SharePlus.instance.share(
                      ShareParams(
                        text: value,
                      )
                    );
                  },
                  icon: const Icon(Icons.share),
                  label: const Text("Share"),
                ),
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}