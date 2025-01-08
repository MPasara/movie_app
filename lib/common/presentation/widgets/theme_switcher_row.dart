import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/common/domain/notifiers/theme_notifier.dart';
import 'package:movie_app/common/presentation/build_context_extensions.dart';
import 'package:movie_app/common/presentation/spacing.dart';
import 'package:movie_app/common/presentation/widgets/drawer_section_header.dart';
import 'package:movie_app/common/presentation/widgets/theme_switch_button.dart';
import 'package:movie_app/generated/l10n.dart';

class ThemeSwitcherRow extends StatelessWidget {
  const ThemeSwitcherRow({
    super.key,
    required this.selectedTheme,
    required this.themeNotifier,
  });

  final ThemeMode selectedTheme;
  final ThemeNotifier themeNotifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerSectionHeader(header: S.of(context).appearance),
        spacing14,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ThemeSwitchButton.light(
              bgColor: selectedTheme == ThemeMode.light
                  ? context.appColors.defaultColor
                  : context.appColors.secondary,
              onTap: () {
                HapticFeedback.mediumImpact();
                themeNotifier.setThemeMode(ThemeMode.light);
              },
            ),
            spacing14,
            ThemeSwitchButton.system(
              bgColor: selectedTheme == ThemeMode.system
                  ? context.appColors.defaultColor
                  : context.appColors.secondary,
              onTap: () {
                HapticFeedback.mediumImpact();
                themeNotifier.setThemeMode(ThemeMode.system);
              },
            ),
            spacing14,
            ThemeSwitchButton.dark(
              bgColor: selectedTheme == ThemeMode.dark
                  ? context.appColors.defaultColor
                  : context.appColors.secondary,
              onTap: () {
                HapticFeedback.mediumImpact();
                themeNotifier.setThemeMode(ThemeMode.dark);
              },
            ),
          ],
        ),
      ],
    );
  }
}
