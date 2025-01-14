import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localStorageServiceProvider = Provider<LocalStorageService>(
  (ref) => LocalStorageServiceImpl(),
  name: 'Local Storage Service Provider',
);

abstract class LocalStorageService {
  Future<String?> getLanguageCode();
  Future<void> setLanguageCode(String languageCode);

  Future<String?> getThemeMode();
  Future<void> setThemeMode(String themeMode);
}

class LocalStorageServiceImpl implements LocalStorageService {
  static const String _localeKey = 'app_locale';
  static const String _themeKey = 'theme_mode';

  @override
  Future<String?> getLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_localeKey);
  }

  @override
  Future<void> setLanguageCode(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, languageCode);
  }

  @override
  Future<String?> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_themeKey);
  }

  @override
  Future<void> setThemeMode(String themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, themeMode);
  }
}
