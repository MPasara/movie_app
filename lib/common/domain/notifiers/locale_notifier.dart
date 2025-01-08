import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/utils/constants/locale_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localeNotifierProvider = NotifierProvider<LocaleNotifier, Locale>(
  () => LocaleNotifier(),
  name: 'Locale Notifier Provider',
);

class LocaleNotifier extends Notifier<Locale> {
  static const String _localeKey = 'app_locale';

  @override
  Locale build() {
    _initializeLocale();
    return const Locale(LocaleConstants.eng);
  }

  Future<void> _initializeLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLocale = prefs.getString(_localeKey);
    if (savedLocale != null && savedLocale.isNotEmpty) {
      state = Locale(savedLocale);
    }
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale.languageCode);
  }
}
