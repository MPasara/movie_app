import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/data/local_storage_service.dart';
import 'package:movie_app/generated/l10n.dart';
import 'package:q_architecture/q_architecture.dart';

final themeRepositoryProvider = Provider<ThemeRepository>(
  (ref) => ThemeRepositoryImpl(
    ref.watch(localStorageServiceProvider),
  ),
  name: 'Theme Repository Provider',
);

abstract class ThemeRepository {
  EitherFailureOr<void> setThemeMode(ThemeMode themeMode);
  EitherFailureOr<ThemeMode> getThemeMode();
}

class ThemeRepositoryImpl implements ThemeRepository {
  ThemeRepositoryImpl(this._localStorageService);

  final LocalStorageService _localStorageService;

  @override
  EitherFailureOr<ThemeMode> getThemeMode() async {
    try {
      final theme = await _localStorageService.getThemeMode();
      switch (theme) {
        case 'light':
          return Right(ThemeMode.light);
        case 'dark':
          return Right(ThemeMode.dark);
        default:
          return Right(ThemeMode.system);
      }
    } catch (e, st) {
      return Left(
        Failure(
          title: S.current.set_theme_failed,
          error: e,
          stackTrace: st,
        ),
      );
    }
  }

  @override
  EitherFailureOr<void> setThemeMode(ThemeMode themeMode) async {
    try {
      final theme = await _localStorageService.setThemeMode(themeMode.name);
      return Right(theme);
    } catch (e, st) {
      return Left(
        Failure(
          title: S.current.set_theme_failed,
          error: e,
          stackTrace: st,
        ),
      );
    }
  }
}
