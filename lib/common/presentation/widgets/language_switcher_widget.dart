import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/domain/notifiers/locale_notifier.dart';
import 'package:movie_app/common/presentation/build_context_extensions.dart';
import 'package:movie_app/common/presentation/spacing.dart';
import 'package:movie_app/common/presentation/widgets/drawer_section_header.dart';
import 'package:movie_app/common/utils/constants/locale_constants.dart';
import 'package:movie_app/generated/l10n.dart';

class CustomLanguageSwitcher extends ConsumerStatefulWidget {
  const CustomLanguageSwitcher({super.key});

  @override
  ConsumerState<CustomLanguageSwitcher> createState() =>
      _CustomLanguageSwitcherState();
}

class _CustomLanguageSwitcherState
    extends ConsumerState<CustomLanguageSwitcher> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final currentLocale = ref.watch(localeNotifierProvider);
    final localeNotifier = ref.read(localeNotifierProvider.notifier);

    final locales = {
      LocaleConstants.eng: S.of(context).english,
      LocaleConstants.cro: S.of(context).croatian,
      LocaleConstants.spanish: S.of(context).spanish,
    };

    return Column(
      children: [
        DrawerSectionHeader(
          header: S.of(context).language,
        ),
        spacing14,
        ExpansionTile(
          tilePadding: EdgeInsets.only(left: 25, right: 25),
          title: Text(
            locales[currentLocale.languageCode] ?? S.of(context).english,
            style: context.appTextStyles.regular,
          ),
          trailing: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(6),
            child: Icon(
              _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: _isExpanded
                  ? context.appColors.secondary
                  : context.appColors.defaultColor,
            ),
          ),
          onExpansionChanged: (bool expanded) {
            setState(
              () => _isExpanded = expanded,
            );
          },
          children: locales.entries.map((entry) {
            final localeCode = entry.key;
            final localeName = entry.value;
            return RadioListTile<String>(
              value: localeCode,
              groupValue: currentLocale.languageCode,
              onChanged: (selectedLocale) {
                if (selectedLocale != null) {
                  localeNotifier.setLocale(Locale(selectedLocale));
                }
              },
              title: Text(
                localeName,
                style: context.appTextStyles.regular,
              ),
              activeColor: context.appColors.secondary,
              tileColor: context.appColors.background,
            );
          }).toList(),
        ),
      ],
    );
  }
}
