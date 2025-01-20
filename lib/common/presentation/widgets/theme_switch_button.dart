import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/presentation/build_context_extensions.dart';
import 'package:movie_app/generated/l10n.dart';

class ThemeSwitchButton extends ConsumerWidget {
  const ThemeSwitchButton._({
    required this.text,
    required this.icon,
    required this.onTap,
    required this.bgColor,
  });

  final Function() onTap;
  final String text;
  final IconData icon;
  final Color? bgColor;

  factory ThemeSwitchButton.light({
    required Function() onTap,
    required Color? bgColor,
  }) {
    return ThemeSwitchButton._(
      text: S.current.light,
      icon: Icons.light_mode,
      onTap: onTap,
      bgColor: bgColor,
    );
  }

  factory ThemeSwitchButton.system({
    required Function() onTap,
    required Color? bgColor,
  }) {
    return ThemeSwitchButton._(
      text: S.current.system,
      icon: Icons.phone_android_rounded,
      onTap: onTap,
      bgColor: bgColor,
    );
  }

  factory ThemeSwitchButton.dark({
    required Function() onTap,
    required Color? bgColor,
  }) {
    return ThemeSwitchButton._(
      text: S.current.dark,
      icon: Icons.dark_mode,
      onTap: onTap,
      bgColor: bgColor,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        splashColor: context.appColors.defaultColor!.withValues(alpha: 0.2),
        highlightColor: context.appColors.defaultColor!.withValues(alpha: 0.2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: bgColor,
              borderRadius: BorderRadius.circular(
                8,
              ),
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(8),
                splashColor:
                    context.appColors.background!.withValues(alpha: 0.2),
                child: SizedBox(
                  width: 75,
                  height: 75,
                  child: Center(
                    child: Icon(
                      icon,
                      color: context.appColors.background,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              text,
              style: context.appTextStyles.regular,
            ),
          ],
        ),
      ),
    );
  }
}
