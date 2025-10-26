import 'package:flutter/material.dart';
import 'package:tharad_tech_task/core/utils/app_style.dart'
    show getResponsiveFontSize;
import 'package:tharad_tech_task/core/utils/constant.dart';
import 'package:tharad_tech_task/core/widgets/custom_check_box.dart';

class RememberandForgotPassword extends StatelessWidget {
  const RememberandForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {},
          child: Text(
            ' هل نسيت كلمة المرور؟',
            style: TextStyle(
              color: AppColors.kPrimaryColor,
              fontSize: getResponsiveFontSize(context, fontSize: 12),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Row(
          children: [
            Text(
              'تذكرني',
              style: TextStyle(
                color: Color(0xff0D1D1E),
                fontSize: getResponsiveFontSize(context, fontSize: 12),
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(width: 6),
            CustomCheckBox(),
          ],
        ),
      ],
    );
  }
}
