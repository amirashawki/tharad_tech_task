import 'package:flutter/material.dart';
import 'package:tharad_tech_task/features/auth/presentation/views/widgets/Verification_password.dart'
    show VerityPassword;

import '../../../../core/utils/app_style.dart';

class VerifyPasswordView extends StatelessWidget {
  const VerifyPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 120),
              // SvgPicture.asset('assets/images/logo.svg'),
              Center(child: Image.asset('assets/images/logo1.png')),
              SizedBox(height: 100),
              Center(
                child: Text(
                  ' رمز التحقق',
                  style: AppStyle.styleBold20(context).copyWith(
                    fontSize: getResponsiveFontSize(context, fontSize: 24),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Text(
                ' لاستكمال فتح حسابك ادخل رمز التحقق المرسل عبر  \n البريد الإلكتروني',
                textAlign: TextAlign.center,
                style: TextStyle().copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: getResponsiveFontSize(context, fontSize: 12),
                  color: Color(0xff998C8C),
                ),
              ),

              SizedBox(height: 40),
              VerityPassword(),
            ],
          ),
        ),
      ),
    );
  }
}
