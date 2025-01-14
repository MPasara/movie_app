import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/data/repositories/theme_repository.dart';
import 'package:movie_app/common/domain/providers/failure_provider.dart';

final themeNotifierProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  () => ThemeNotifier(),
  name: 'Theme Notifier Provider',
);

class ThemeNotifier extends Notifier<ThemeMode> {
  late ThemeRepository _themeRepository;

  @override
  ThemeMode build() {
    _themeRepository = ref.watch(themeRepositoryProvider);
    _initializeTheme();
    return ThemeMode.system;
  }

  Future<void> _initializeTheme() async {
    final eitherFailureOrThemeMode = await _themeRepository.getThemeMode();
    eitherFailureOrThemeMode.fold(
      (failure) => ref.read(failureProvider.notifier).state = failure,
      (themeMode) {
        state = themeMode;
      },
    );
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    state = themeMode;
    await _themeRepository.setThemeMode(themeMode);
  }
}
