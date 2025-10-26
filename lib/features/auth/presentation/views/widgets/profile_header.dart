import 'package:flutter/material.dart'
    show Colors, ListTile, center, ListTileTitleAlignment;
import 'package:flutter/widgets.dart';
import 'package:tharad_tech_task/core/utils/app_style.dart'
    show getResponsiveFontSize, AppStyle;

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF5CC7A3), Color(0xFF5CC7A3), Color(0xFF265355)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Center(
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 30, right: 30),
          titleAlignment: ListTileTitleAlignment.center,
          title: Center(
            child: Text(
              'الملف الشخصي',
              style: AppStyle.styleBold20(context).copyWith(
                fontSize: getResponsiveFontSize(context, fontSize: 16),
                color: Colors.white,
              ),
            ),
          ),

          leading: Image.asset('assets/images/icon.png', height: 40, width: 40),
        ),
      ),
    );
  }
}
