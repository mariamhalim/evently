import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static final ThemeData DarkTheme = ThemeData(
    primaryColor: AppColors.navyBlueColor,
    scaffoldBackgroundColor: AppColors.navyBlueColor,
    focusColor: AppColors.blueColor,
    dividerColor: AppColors.navyBlueColor,
    cardColor: AppColors.whiteColor,
    canvasColor: AppColors.blueColor,
    highlightColor: AppColors.whiteColor,
    textTheme: TextTheme(
      headlineLarge: AppStyles.bold20Wight,
      headlineMedium: AppStyles.MidWight16,
      headlineSmall: AppStyles.bold14Navy,
      bodyLarge: AppStyles.MidNavtt16,
      bodyMedium: AppStyles.MidWight16,
      labelMedium: AppStyles.MidNavtt16,
      bodySmall: AppStyles.MidWight16,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.blueColor,
      selectedItemColor: AppColors.whiteColor,
      unselectedItemColor: AppColors.whiteColor,
      type: BottomNavigationBarType.fixed,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.navyBlueColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(35),
        side: BorderSide(color: AppColors.whiteColor, width: 6),
      ),
    ),
  );
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.blueColor,
    scaffoldBackgroundColor: AppColors.whiteColor,
    focusColor: AppColors.whiteColor,
    dividerColor: AppColors.whiteColor,
    cardColor: AppColors.blackColor,
    canvasColor: AppColors.greyColor,
    highlightColor: AppColors.greyColor,
    textTheme: TextTheme(
      headlineLarge: AppStyles.bold20Black,
      headlineMedium: AppStyles.MidBlack16,
      headlineSmall: AppStyles.bold14blue,
        bodyLarge: AppStyles.MidWight16,
        bodyMedium: AppStyles.MidBluet16,
        labelMedium: AppStyles.MidBluet16
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.navyBlueColor,
      selectedItemColor: AppColors.whiteColor,
      unselectedItemColor: AppColors.whiteColor,
      type: BottomNavigationBarType.fixed,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.blueColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(35),
        side: BorderSide(color: AppColors.whiteColor, width: 6),
      ),
    ),
  );
}
