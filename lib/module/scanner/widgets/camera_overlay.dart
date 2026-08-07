import 'package:flutter/material.dart';
import 'package:qr_code_generator_reader/app/theme/app_colors.dart';

class CameraOverlay extends StatelessWidget{
  const CameraOverlay({super.key});

  @override
  Widget build(BuildContext context){
    return IgnorePointer(
      child: Center(
        child: Container(
          width: 260,
          height: 260,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.white,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              _corner(Alignment.topLeft),
              _corner(Alignment.topRight),
              _corner(Alignment.bottomLeft),
              _corner(Alignment.bottomRight),
            ],
          ),
        ),
      ),
    );
  }

  Widget _corner(Alignment alignment){
    return Align(
      alignment: alignment,
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}