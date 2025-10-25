import 'package:flutter/material.dart';
import 'package:tharad_tech_task/core/utils/constant.dart';

class ArrowBackButton extends StatelessWidget {
  const ArrowBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back, color: AppColors.kPrimaryColor),
    );
  }
}
