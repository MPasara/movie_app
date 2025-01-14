import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/presentation/build_context_extensions.dart';
import 'package:movie_app/common/presentation/spacing.dart';
import 'package:movie_app/common/presentation/widgets/app_version_label.dart';
import 'package:movie_app/common/presentation/widgets/language_switcher_widget.dart';
import 'package:movie_app/common/presentation/widgets/theme_switcher_row.dart';
import 'package:movie_app/generated/l10n.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
      child: Drawer(
        width: 300,
        backgroundColor: context.appColors.background,
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      S.of(context).general,
                      style: context.appTextStyles.boldLarge,
                    ),
                    Spacer(),
                    // LanguageSwitcherWidget(),
                    CustomLanguageSwitcher(),
                    spacing22,
                    ThemeSwitcherRow(),
                    Spacer(flex: 2),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: AppVersionLabel(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
