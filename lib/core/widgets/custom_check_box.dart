import 'package:evolvify/core/utils/constant.dart';

import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({super.key});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        height: 10,
        width: 10,

        decoration: BoxDecoration(
          color: isSelected == true ? AppColors.kPrimaryColor : null,
          border: Border.all(color: Color(0xffA1A1A1)),
        ),
        child: Icon(
          isSelected == true ? Icons.check : null,
          size: 8,
          color: Colors.white,
        ),
      ),
    );
  }
}
