import 'package:flutter/material.dart';
import 'package:tharad_tech_task/core/utils/app_style.dart'
    show getResponsiveFontSize;
import 'package:tharad_tech_task/core/utils/constant.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({
    super.key,
    required this.text1,
    required this.text2,
    this.onTap,
  });
  final String text1, text2;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Text(
            text1,
            style: TextStyle(
              fontSize: getResponsiveFontSize(context, fontSize: 12),
              fontWeight: FontWeight.w500,
              color: AppColors.kPrimaryColor,
            ),
          ),
        ),

        Text(
          text2,
          style: TextStyle(
            fontSize: getResponsiveFontSize(context, fontSize: 12),
            fontWeight: FontWeight.w500,
            color: AppColors.kbackColor,
          ),
        ),
      ],
    );
  }
}
