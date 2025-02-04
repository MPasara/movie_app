import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/common/data/repositories/theme_repository.dart';
import 'package:movie_app/generated/l10n.dart';

import '../../../test_variables.dart';

void main() {
  late ThemeRepository repository;
  late MockLocalStorageService mockLocalStorageService;

  setUp(() async {
    // Load localization
    await S.load(const Locale.fromSubtags(languageCode: 'en'));

    // Initialize mocks
    mockLocalStorageService = MockLocalStorageService();

    // Setup repository with mocks
    repository = ThemeRepositoryImpl(mockLocalStorageService);
  });

  group('getThemeMode', () {
    test('should return Right with ThemeMode.light when storage returns light',
        () async {
      // Arrange
      when(() => mockLocalStorageService.getThemeMode())
          .thenAnswer((_) async => 'light');

      // Act
      final result = await repository.getThemeMode();

      // Assert
      expect(result.isRight, true);
      expect(result.right, ThemeMode.light);
      verify(() => mockLocalStorageService.getThemeMode()).called(1);
    });

    test('should return Right with ThemeMode.dark when storage returns dark',
        () async {
      // Arrange
      when(() => mockLocalStorageService.getThemeMode())
          .thenAnswer((_) async => 'dark');

      // Act
      final result = await repository.getThemeMode();

      // Assert
      expect(result.isRight, true);
      expect(result.right, ThemeMode.dark);
      verify(() => mockLocalStorageService.getThemeMode()).called(1);
    });

    test(
        'should return Right with ThemeMode.system when storage returns unknown value',
        () async {
      // Arrange
      when(() => mockLocalStorageService.getThemeMode())
          .thenAnswer((_) async => 'unknown');

      // Act
      final result = await repository.getThemeMode();

      // Assert
      expect(result.isRight, true);
      expect(result.right, ThemeMode.system);
      verify(() => mockLocalStorageService.getThemeMode()).called(1);
    });

    test('should return Left with failure when storage throws exception',
        () async {
      // Arrange
      when(() => mockLocalStorageService.getThemeMode())
          .thenThrow(Exception('Storage error'));

      // Act
      final result = await repository.getThemeMode();

      // Assert
      expect(result.isLeft, true);
      expect(result.left.title, S.current.set_theme_failed);
      verify(() => mockLocalStorageService.getThemeMode()).called(1);
    });
  });

  group('setThemeMode', () {
    test('should return Right when setting theme mode is successful', () async {
      // Arrange
      when(() => mockLocalStorageService.setThemeMode(any()))
          .thenAnswer((_) async {});

      // Act
      final result = await repository.setThemeMode(ThemeMode.dark);

      // Assert
      expect(result.isRight, true);
      verify(() => mockLocalStorageService.setThemeMode('dark')).called(1);
    });

    test('should return Left with failure when setting theme mode fails',
        () async {
      // Arrange
      when(() => mockLocalStorageService.setThemeMode(any()))
          .thenThrow(Exception('Storage error'));

      // Act
      final result = await repository.setThemeMode(ThemeMode.light);

      // Assert
      expect(result.isLeft, true);
      expect(result.left.title, S.current.set_theme_failed);
      verify(() => mockLocalStorageService.setThemeMode('light')).called(1);
    });
  });
}
