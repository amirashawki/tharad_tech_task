import 'dart:developer';

import 'package:evolvify/core/utils/constant.dart';
import 'package:flutter/material.dart';

abstract class AppStyle {
  static TextStyle styleBold52(context) {
    return TextStyle(
      color: AppColors.kPrimaryColor,
      fontWeight: FontWeight.bold,
      fontSize: getResponsiveFontSize(context, fontSize: 52),
      fontFamily: 'PlusJakartaSans',
    );
  }

  static TextStyle styleMedium20(context) {
    return TextStyle(
      color: AppColors.kPrimaryColor,
      fontWeight: FontWeight.w500,
      fontSize: getResponsiveFontSize(context, fontSize: 20),
      fontFamily: 'PlusJakartaSans',
    );
  }

  static TextStyle styleRegular14(context) {
    return TextStyle(
      color: Color(0xff070707),
      fontWeight: FontWeight.w400,
      fontSize: getResponsiveFontSize(context, fontSize: 14),
      fontFamily: 'Roboto',
    );
  }

  static TextStyle styleRegular15(context) {
    return TextStyle(
      color: AppColors.kPrimaryColor,
      fontWeight: FontWeight.w600,
      fontSize: getResponsiveFontSize(context, fontSize: 14),
      fontFamily: 'PlusJakartaSans',
    );
  }

  static TextStyle styleNexa15(context) => TextStyle(
    color: Color(0xff868686),
    fontSize: getResponsiveFontSize(context, fontSize: 15),
    // fontFamily: 'Nexa',
    fontWeight: FontWeight.w600,
  );
  static TextStyle styleMedium28(context) => TextStyle(
    color: AppColors.kPrimaryColor,
    fontSize: getResponsiveFontSize(context, fontSize: 28),
    fontWeight: FontWeight.bold,
    fontFamily: 'PlusJakartaSans',
  );
  static TextStyle styleSemiBold24(context) => TextStyle(
    color: AppColors.kPrimaryColor,
    fontSize: getResponsiveFontSize(context, fontSize: 24),
    fontWeight: FontWeight.w600,
    fontFamily: 'PlusJakartaSans',
  );
  static TextStyle styleMedium14(context) => TextStyle(
    color: Color(0xff7A7A7A),
    fontSize: getResponsiveFontSize(context, fontSize: 14),
    fontWeight: FontWeight.w500,
    fontFamily: 'PlusJakartaSans',
  );
  static TextStyle styleBold22(context) => TextStyle(
    color: Color(0xff0B121F),
    fontSize: getResponsiveFontSize(context, fontSize: 22),
    fontWeight: FontWeight.w700,
    fontFamily: 'PlusJakartaSans',
  );

  static TextStyle styleRegularGrey14(context) => TextStyle(
    color: Color(0xff70747E),
    fontSize: getResponsiveFontSize(context, fontSize: 14),
    fontWeight: FontWeight.w400,
    fontFamily: 'PlusJakartaSans',
  );
}

// sacleFactor
// responsive font size
// (min , max) fontsize
double getResponsiveFontSize(context, {required double fontSize}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = fontSize * scaleFactor;

  double lowerLimit = fontSize * .8;
  double upperLimit = fontSize * 1.2;

  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(context) {
  // var dispatcher = PlatformDispatcher.instance;
  // var physicalWidth = dispatcher.views.first.physicalSize.width;
  // var devicePixelRatio = dispatcher.views.first.devicePixelRatio;
  // double width = physicalWidth / devicePixelRatio;

  double width = MediaQuery.sizeOf(context).width;
  log(width.toString());
  if (width < 600) {
    return width / 550;
  } else if (width < 1000) {
    return width / 850;
  } else {
    return width / 1800;
  }
}
