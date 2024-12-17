import 'package:flutter/material.dart';

final class AppColors extends ThemeExtension<AppColors> {
  final Color? defaultColor;
  final Color? secondary;
  final Color? background;
  final Color? genreTagBackground;
  final Color? bottomNavBarBackground;
  final Color? errorRed;
  final Color? successGreen;

  const AppColors({
    required this.defaultColor,
    required this.secondary,
    required this.background,
    required this.bottomNavBarBackground,
    required this.genreTagBackground,
    required this.errorRed,
    required this.successGreen,
  });

  @override
  AppColors copyWith({
    Color? defaultColor,
    Color? secondary,
    Color? background,
    Color? genreTagBackground,
    Color? bottomNavBarBackground,
    Color? errorRed,
    Color? successGreen,
  }) {
    return AppColors(
      defaultColor: defaultColor ?? this.defaultColor,
      secondary: secondary ?? this.secondary,
      background: background ?? this.background,
      genreTagBackground: genreTagBackground ?? this.genreTagBackground,
      bottomNavBarBackground:
          bottomNavBarBackground ?? this.bottomNavBarBackground,
      errorRed: errorRed ?? this.errorRed,
      successGreen: successGreen ?? this.successGreen,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      defaultColor: Color.lerp(defaultColor, other.defaultColor, t),
      secondary: Color.lerp(secondary, other.secondary, t),
      background: Color.lerp(background, other.background, t),
      genreTagBackground:
          Color.lerp(genreTagBackground, other.genreTagBackground, t),
      bottomNavBarBackground:
          Color.lerp(bottomNavBarBackground, other.bottomNavBarBackground, t),
      errorRed: Color.lerp(errorRed, other.errorRed, t),
      successGreen: Color.lerp(successGreen, other.successGreen, t),
    );
  }
}
