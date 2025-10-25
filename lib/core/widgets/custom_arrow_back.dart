import 'package:flutter/material.dart';
import 'package:tharad_tech_task/core/widgets/arrow_button.dart' show ArrowBackButton;

class CustomArrowBack extends StatelessWidget {
  const CustomArrowBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14),
      child: Align(alignment: Alignment.topLeft, child: ArrowBackButton()),
    );
  }
}
