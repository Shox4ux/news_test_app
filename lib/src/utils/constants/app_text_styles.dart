import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_test_app/src/utils/constants/app_colors.dart';

abstract class AppStyles {
  static TextStyle subtitleTextStyle = TextStyle(
      fontSize: 16.sp,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      color: AppColors.subtitleColor);
}
