
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tharad_tech_task/core/utils/app_style.dart' show getResponsiveFontSize;
import 'package:tharad_tech_task/core/widgets/custom_check_box.dart';

class RememberandForgotPassword extends StatelessWidget {
  const RememberandForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            CustomCheckBox(),
            SizedBox(width: 6),
            Text(
              'تذكرني',
              style: TextStyle(
                color: Color(0xffA1A1A1),
                fontSize: getResponsiveFontSize(context, fontSize: 14),
                fontWeight: FontWeight.w400,
                fontFamily: 'Robto',
              ),
            ),
          ],
        ),
        Spacer(),

        GestureDetector(
          onTap: () {
         
          },
          child: Text(
            ' هل نسيت كلمة المرور؟',
            style: TextStyle(
              color: Color(0xffA1A1A1),
              fontSize: getResponsiveFontSize(context, fontSize: 14),
              fontWeight: FontWeight.w400,
              fontFamily: 'Robto',
            ),
          ),
        ),
      ],
    );
  }
}
