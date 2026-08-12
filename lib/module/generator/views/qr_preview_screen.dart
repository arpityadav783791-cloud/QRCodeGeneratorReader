import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_generator_reader/app/theme/app_colors.dart';
import 'package:qr_code_generator_reader/app/theme/app_text_styles.dart';
import 'package:qr_code_generator_reader/module/generator/controllers/qr_preview_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRPreviewScreen extends GetView<QRPreviewController>{
  const QRPreviewScreen({super.key});
  static final GlobalKey qrKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        centerTitle: true,

        title: Text(
          "QR Preview",
          style: AppTextStyles.headingMedium,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,

          ),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              RepaintBoundary(
                key: qrKey,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                
                  child: Obx(
                    () => QrImageView(
                      data: controller.qrData.value,
                      size: 260,
                      version: QrVersions.auto,
                    )
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              Text(
                "Generated QR",
                style: AppTextStyles.headingMedium,
              ),
              const SizedBox(height: 10,),
              Obx(
                () => Text(
                  controller.qrData.value,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium,
                ),
              ),
              const SizedBox(height: 35,),

              Row(
                children: [
                  Expanded(
                    child: _ActionButton(
                      icon: Icons.download,
                      label: "Download",
                      onTap: (){
                        controller.downloadQR(qrKey);
                      },
                    ),
                  ),
                  const SizedBox(width: 12,),
                  Expanded(
                    child: _ActionButton(
                      icon: Icons.share,
                      label: "Share",
                      onTap: (){
                        controller.shareQR(qrKey);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _ActionButton(
                      icon: Icons.copy,
                      label: "Copy",
                      onTap: controller.copyQR,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _ActionButton(
                      icon: Icons.save,
                      label: "Save",
                      onTap: controller.saveQR,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),

                  child: Text("Generate Another", style: AppTextStyles.button),
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,

      child: ElevatedButton.icon(
        onPressed: onTap,

        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.white,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),

        icon: Icon(icon),

        label: Text(label, style: AppTextStyles.button),
      ),
    );
  }
}
