import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';
import 'constants.dart';

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.whiteColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightPurple,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: AppColors.darkPurple,
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        fontFamily: AppConstants.textFontFamily,
      ),
    ),
    textTheme: TextTheme(
      headlineSmall: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.textColor,
        fontFamily: AppConstants.textFontFamily,
      ),
      headlineMedium: TextStyle(
        fontSize: 26.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.textColor,
        fontFamily: AppConstants.textFontFamily,
      ),
      headlineLarge: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.textColor,
        fontFamily: AppConstants.textFontFamily,
      ),
      bodySmall: TextStyle(
        fontSize: 16.sp,
        color: AppColors.blackColor,
        fontFamily: AppConstants.textFontFamily,
      ),
      bodyMedium: TextStyle(
        fontSize: 20.sp,
        color: AppColors.blackColor,
        fontFamily: AppConstants.textFontFamily,
      ),
      bodyLarge: TextStyle(
        fontSize: 24.sp,
        color: AppColors.blackColor,
        fontFamily: AppConstants.textFontFamily,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.whiteColor,
      unselectedItemColor: AppColors.darkGrey,
      unselectedIconTheme: IconThemeData(
        color: AppColors.darkGrey,
        size: 30.r,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.darkGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      selectedItemColor: AppColors.darkPurple,
      selectedIconTheme: IconThemeData(
        color: AppColors.darkPurple,
        size: 30.r,
      ),
      selectedLabelStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.darkPurple,
        fontFamily: AppConstants.textFontFamily,
      ),
    ),
    tabBarTheme: TabBarTheme(
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: AppColors.darkPurple,
      unselectedLabelColor: AppColors.darkGrey,
      labelStyle: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.darkPurple,
        fontFamily: AppConstants.textFontFamily,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.darkGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
    ),
  );
}

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
  );
}
