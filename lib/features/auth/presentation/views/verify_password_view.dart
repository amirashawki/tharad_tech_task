
import 'package:flutter/material.dart';
import 'package:tharad_tech_task/core/widgets/custom_arrow_back.dart';
import 'package:tharad_tech_task/features/auth/presentation/views/widgets/Verification_password.dart' show VerityPassword;

import '../../../../core/utils/app_style.dart';


class VerifyPasswordView extends StatelessWidget {
  const VerifyPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(top: 53, child: CustomArrowBack()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 55),
                // Text(
                //   'Verification',
                //   style: AppStyle.styleMedium28(context).copyWith(
                //     fontSize: getResponsiveFontSize(context, fontSize: 24),
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
                const SizedBox(height: 24),

                
                const SizedBox(height: 11),
                Text(
                  'Evolvify',
                  style: AppStyle.styleBold20(context).copyWith(
                    fontSize: getResponsiveFontSize(context, fontSize: 24),
                  ),
                ),

                SizedBox(height: 52),
                VerityPassword(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
