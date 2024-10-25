// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

final secondaryTheme = _getTheme(
  appColors: const AppColors(
    defaultColor: Color(0xFFFFFFFF),
    secondary: Color(0xFFec9b3e), //#ec9b3e
    background: Color(0xFF0E1324),
    bottomNavBarBackground: Color(0xFF010510),
    genreTagBackground: Color(0x33ec9b3e33),
  ),
);

final primaryTheme = _getTheme(
  appColors: const AppColors(
    defaultColor: Color(0xFF000000),
    secondary: Color(0xFF253899),
    background: Color(0xFFFFFFFF),
    bottomNavBarBackground: Color(0xFFF8F8FA),
    genreTagBackground: Color(0xff253899),
  ),
);

ThemeData _getTheme({required AppColors appColors}) {
  return ThemeData(
    primarySwatch: Colors.cyan,
    colorScheme: ThemeData().colorScheme.copyWith(
          primary: appColors.defaultColor,
          secondary: appColors.secondary,
        ),
    scaffoldBackgroundColor: appColors.background,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: appColors.defaultColor,
      selectionColor: appColors.defaultColor?.withOpacity(0.2),
      selectionHandleColor: appColors.defaultColor,
    ),
    extensions: [
      appColors,
      getAppTextStyles(defaultColor: appColors.defaultColor!),
    ],
  );
}
