import 'package:ae_kits/theme/app_color.dart';
import 'package:ae_kits/theme/my_text_styles.dart';
import 'package:flutter/material.dart';


class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColor.primary,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColor.secondary,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.accent,
      foregroundColor: AppColor.white,
      titleTextStyle: MyTextStyles.titleBold.copyWith(color: AppColor.white),
      iconTheme: IconThemeData(color: AppColor.white),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColor.primary,
      error: AppColor.failed,
      onPrimary: AppColor.primary,
      onSecondary: AppColor.secondary,
      secondary: AppColor.secondary,
      primary: AppColor.primary,
    ),
    useMaterial3: true,
  );
}
