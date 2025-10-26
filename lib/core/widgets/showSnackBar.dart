import 'package:flutter/material.dart';
import 'package:tharad_tech_task/core/utils/constant.dart';

void showSnackBar(BuildContext context, {required String text}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: AppColors.kPrimaryColor,
    ),
  );
}
