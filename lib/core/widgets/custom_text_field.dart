import 'package:flutter/material.dart';
import 'package:tharad_tech_task/core/utils/app_style.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    this.hintText,
    this.onChanged,
    this.validate,
    this.obscureText = false,
    this.prefixIcon,

    this.controller,
  });
  String? hintText;

  Widget? prefixIcon;
  bool? obscureText;
  TextEditingController? controller;
  Function(String)? onChanged;
  String? Function(String?)? validate;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF4F7F6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xffF0E6DE)),
      ),

      child: TextFormField(
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,

        validator: validate,
        controller: controller,
        obscureText: obscureText!,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: getResponsiveFontSize(context, fontSize: 11),
            color: Color(0xffA1A1A1),
            fontWeight: FontWeight.w500,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        ),
      ),
    );
  }
}
