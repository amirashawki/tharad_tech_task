import 'package:flutter/material.dart';
import 'package:tharad_tech_task/core/utils/app_style.dart';

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
          gradient: LinearGradient(
            colors: [Color(0xFF5CC7A3), Color(0xFF265355)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 17),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: getResponsiveFontSize(context, fontSize: 12),
                fontWeight: FontWeight.w700,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
