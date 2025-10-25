import 'dart:developer';

import 'package:flutter/material.dart';

abstract class AppStyle {
  static TextStyle styleBold20(context) {
    return TextStyle(
      color: Color(0xff0D1D1E),
      fontWeight: FontWeight.bold,
      fontSize: getResponsiveFontSize(context, fontSize: 20),
      fontFamily: 'Tajawal',
    );
  }
  static TextStyle medium10(context) {
    return TextStyle(
      color: Color(0xff0D1D1E),
      fontWeight: FontWeight.w500,
      fontSize: getResponsiveFontSize(context, fontSize: 10),
      fontFamily: 'Tajawal',
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
