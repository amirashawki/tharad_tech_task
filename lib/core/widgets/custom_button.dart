import 'package:evolvify/core/utils/app_style.dart';
import 'package:evolvify/core/utils/constant.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    this.onTap,
    this.borderRadius,
    this.verticalPadding,
  });
  final String title;
  final double? verticalPadding;
  @override
  final double? borderRadius;
  final void Function()? onTap;
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.kPrimaryColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 15),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 12),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: getResponsiveFontSize(context, fontSize: 20),
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
