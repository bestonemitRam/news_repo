import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shortnews/view/uitl/appColors.dart';
import 'package:shortnews/view/uitl/apphelper.dart';

class AppStyle {
  static final heading_white = TextStyle(
      color: AppColors.whiteColor,
      fontSize: 18.sp,
      fontWeight: FontWeight.w500);
  static final heading_black = TextStyle(
      color: AppColors.blackColor,
      fontSize: 18.sp,
      fontWeight: FontWeight.w500);

  static final bodytext_white = TextStyle(
    color: AppColors.whiteColor, fontSize: 15.sp,
    //fontFamily: 'Oswald'
  );
  static final bodytext_black = TextStyle(
    color: AppColors.blackColor,
    fontSize: 15.sp,
    wordSpacing: 2,
  );
  static final cardtitles = TextStyle(
    color: AppHelper.themelight ? AppColors.whiteColor : AppColors.blackColor,
    fontSize: 17.sp,
    //fontFamily: 'Oswald',
    wordSpacing: 2,
  );
}
