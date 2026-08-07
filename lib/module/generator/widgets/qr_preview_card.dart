import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:qr_code_generator_reader/app/theme/app_colors.dart';
import 'package:qr_code_generator_reader/app/theme/app_text_styles.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRPreviewCard extends StatelessWidget{
  final RxString qrData;

  const QRPreviewCard({
    super.key,
    required this.qrData,
  });

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Text(
          "QR preview",
          style: AppTextStyles.headingMedium,
          
        ),
        const SizedBox(height: 20,),

        Obx(
          () => Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),

            child: Center(
              child: QrImageView(
                data: qrData.value.isEmpty?"QR Vault":qrData.value,
                version: QrVersions.auto,
                size: 220,
              ),
            ),
          )
        )
      ],
    );
  }
}