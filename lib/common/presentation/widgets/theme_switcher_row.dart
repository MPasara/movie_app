import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/domain/notifiers/theme_notifier.dart';
import 'package:movie_app/common/presentation/build_context_extensions.dart';
import 'package:movie_app/common/presentation/spacing.dart';
import 'package:movie_app/common/presentation/widgets/drawer_section_header.dart';
import 'package:movie_app/common/presentation/widgets/theme_switch_button.dart';
import 'package:movie_app/generated/l10n.dart';

class ThemeSwitcherRow extends ConsumerWidget {
  const ThemeSwitcherRow({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTheme = ref.watch(themeNotifierProvider);
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
                ref
                    .read(themeNotifierProvider.notifier)
                    .setThemeMode(ThemeMode.light);
              },
            ),
            spacing14,
            ThemeSwitchButton.system(
              bgColor: selectedTheme == ThemeMode.system
                  ? context.appColors.defaultColor
                  : context.appColors.secondary,
              onTap: () {
                HapticFeedback.mediumImpact();
                ref
                    .read(themeNotifierProvider.notifier)
                    .setThemeMode(ThemeMode.system);
              },
            ),
            spacing14,
            ThemeSwitchButton.dark(
              bgColor: selectedTheme == ThemeMode.dark
                  ? context.appColors.defaultColor
                  : context.appColors.secondary,
              onTap: () {
                HapticFeedback.mediumImpact();
                ref
                    .read(themeNotifierProvider.notifier)
                    .setThemeMode(ThemeMode.dark);
              },
            ),
          ],
        ),
      ],
    );
  }
}
