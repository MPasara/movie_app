import 'package:flutter/material.dart';

final class AppTextStyles extends ThemeExtension<AppTextStyles> {
  final TextStyle? regular;
  final TextStyle? bold;
  final TextStyle? boldLarge;
  final TextStyle? pageHeading;
  final TextStyle? movieCardTitle;
  final TextStyle? movieDetailsTitle;
  final TextStyle? movieDescription;
  final TextStyle? movieRating;
  final TextStyle? genreName;

  const AppTextStyles({
    required this.regular,
    required this.bold,
    required this.boldLarge,
    required this.pageHeading,
    required this.movieCardTitle,
    required this.movieDetailsTitle,
    required this.movieDescription,
    required this.movieRating,
    required this.genreName,
  });

  @override
  AppTextStyles copyWith({
    TextStyle? regular,
    TextStyle? bold,
    TextStyle? boldLarge,
    TextStyle? pageHeading,
    TextStyle? movieCardTitle,
    TextStyle? movieDetailsTitle,
    TextStyle? movieDescription,
    TextStyle? movieRating,
    TextStyle? genreName,
  }) {
    return AppTextStyles(
      regular: regular ?? this.regular,
      bold: bold ?? this.bold,
      boldLarge: boldLarge ?? this.boldLarge,
      pageHeading: pageHeading ?? this.pageHeading,
      movieCardTitle: movieCardTitle ?? this.movieCardTitle,
      movieDetailsTitle: movieDetailsTitle ?? this.movieDetailsTitle,
      movieDescription: movieDescription ?? this.movieDescription,
      movieRating: movieRating ?? this.movieRating,
      genreName: genreName ?? this.genreName,
    );
  }

  @override
  AppTextStyles lerp(AppTextStyles? other, double t) {
    if (other is! AppTextStyles) {
      return this;
    }
    return AppTextStyles(
      regular: TextStyle.lerp(regular, other.regular, t),
      bold: TextStyle.lerp(bold, other.bold, t),
      boldLarge: TextStyle.lerp(boldLarge, other.boldLarge, t),
      pageHeading: TextStyle.lerp(pageHeading, other.pageHeading, t),
      movieCardTitle: TextStyle.lerp(movieCardTitle, other.movieCardTitle, t),
      movieDetailsTitle:
          TextStyle.lerp(movieDetailsTitle, other.movieDetailsTitle, t),
      movieDescription:
          TextStyle.lerp(movieDescription, other.movieDescription, t),
      movieRating: TextStyle.lerp(movieRating, other.movieRating, t),
      genreName: TextStyle.lerp(genreName, other.genreName, t),
    );
  }
}

AppTextStyles getAppTextStyles({required Color defaultColor}) {
  final baseTextStyle = TextStyle(
    color: defaultColor,
    fontSize: 14,
    letterSpacing: 0,
  );
  return AppTextStyles(
    regular: baseTextStyle,
    bold: baseTextStyle.copyWith(fontWeight: FontWeight.w700),
    boldLarge:
        baseTextStyle.copyWith(fontWeight: FontWeight.w700, fontSize: 24),
    pageHeading:
        baseTextStyle.copyWith(fontWeight: FontWeight.w600, fontSize: 22),
    movieCardTitle:
        baseTextStyle.copyWith(fontWeight: FontWeight.w600, fontSize: 15),
    movieDetailsTitle:
        baseTextStyle.copyWith(fontWeight: FontWeight.w600, fontSize: 20),
    movieDescription:
        baseTextStyle.copyWith(fontWeight: FontWeight.w300, fontSize: 13),
    movieRating:
        baseTextStyle.copyWith(fontWeight: FontWeight.w400, fontSize: 12),
    genreName:
        baseTextStyle.copyWith(fontWeight: FontWeight.w400, fontSize: 11),
  );
}
