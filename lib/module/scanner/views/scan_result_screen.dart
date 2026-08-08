import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_generator_reader/app/theme/app_colors.dart';
import 'package:qr_code_generator_reader/app/theme/app_text_styles.dart';
import 'package:qr_code_generator_reader/app/utils/app_snackbar.dart';
import 'package:qr_code_generator_reader/module/scanner/controllers/scan_result_type.dart';
import 'package:qr_code_generator_reader/module/scanner/controllers/scanner_controller.dart';
import 'package:share_plus/share_plus.dart';

class ScanResultScreen extends GetView<ScannerController>{
  const ScanResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        centerTitle: true,
        title: Text(
          "scan Result",
          style: AppTextStyles.headingMedium,
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
                style: AppTextStyles.headingSmall,
              ),
              const SizedBox(height: 20,),

              Obx(
                () => Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: SelectableText(
                    controller.scannedValue.value.isEmpty?'NO QR Code Scanned':controller.scannedValue.value,
                    style: AppTextStyles.bodyLarge,
                  ),
                ),
              ),
              const Spacer(),

              Obx(
                () {
                  if(controller.resultType.value != ScanResultType.url){
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
                },
              ),

              const SizedBox(height: 15,),

              SizedBox(
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: () async{
                    final Value = controller.scannedValue.value;

                    if(Value.isEmpty){
                      return ;
                    }
                    await Clipboard.setData(
                      ClipboardData(text: Value),
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