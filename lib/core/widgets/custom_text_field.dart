import 'package:evolvify/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    this.hintText,
    this.onChanged,
    this.validate,
    this.obscureText = false,
    this.suffixIcon,
    this.image,
    this.controller,
  });
  String? hintText, image;

  Widget? suffixIcon;
  bool? obscureText;
  TextEditingController? controller;
  Function(String)? onChanged;
  String? Function(String?)? validate;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 5,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),

      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22, right: 10),
            child: SvgPicture.asset(image!),
          ),
          Expanded(
            child: TextFormField(
              validator: validate,
              controller: controller,
              obscureText: obscureText!,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: getResponsiveFontSize(context, fontSize: 14),
                  color: Color(0xffA1A1A1),
                  fontWeight: FontWeight.w500,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none, // Hides the border
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
