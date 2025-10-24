import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:tharad_tech_task/core/utils/constant.dart';

abstract class AppStyle {
  static TextStyle styleBold52(context) {
    return TextStyle(
      color: AppColors.kPrimaryColor,
      fontWeight: FontWeight.bold,
      fontSize: getResponsiveFontSize(context, fontSize: 52),
      fontFamily: 'PlusJakartaSans',
    );
  }


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
