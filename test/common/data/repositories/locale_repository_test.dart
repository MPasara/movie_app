import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/common/data/repositories/locale_repository.dart';
import 'package:movie_app/generated/l10n.dart';

import '../../../test_variables.dart';

void main() {
  late LocaleRepository repository;
  late MockLocalStorageService mockLocalStorageService;

  setUp(() async {
    // Load localization
    await S.load(const Locale.fromSubtags(languageCode: 'en'));

    // Initialize mocks
    mockLocalStorageService = MockLocalStorageService();

    // Setup repository with mocks
    repository = LocaleRepositoryImpl(mockLocalStorageService);
  });

  group('getLanguage', () {
    test('should return Right with language code when storage returns value',
        () async {
      // Arrange

      when(() => mockLocalStorageService.getLanguageCode())
          .thenAnswer((_) async => languageCode);

      // Act
      final result = await repository.getLanguage();

      // Assert
      expect(result.isRight, true);
      expect(result.right, languageCode);
      verify(() => mockLocalStorageService.getLanguageCode()).called(1);
    });

    test('should return Right with null when storage returns null', () async {
      // Arrange
      when(() => mockLocalStorageService.getLanguageCode())
          .thenAnswer((_) async => null);

      // Act
      final result = await repository.getLanguage();

      // Assert
      expect(result.isRight, true);
      expect(result.right, null);
      verify(() => mockLocalStorageService.getLanguageCode()).called(1);
    });

    test('should return Left with failure when storage throws exception',
        () async {
      // Arrange
      when(() => mockLocalStorageService.getLanguageCode())
          .thenThrow(testException);

      // Act
      final result = await repository.getLanguage();

      // Assert
      expect(result.isLeft, true);
      expect(result.left.title, S.current.fetch_language_failed);
      verify(() => mockLocalStorageService.getLanguageCode()).called(1);
    });
  });

  group('setLanguage', () {
    test('should return Right when setting language is successful', () async {
      // Arrange

      when(() => mockLocalStorageService.setLanguageCode(any()))
          .thenAnswer((_) async {});

      // Act
      final result = await repository.setLanguage(languageCode);

      // Assert
      expect(result.isRight, true);
      verify(() => mockLocalStorageService.setLanguageCode(languageCode))
          .called(1);
    });

    test('should return Left with failure when setting language fails',
        () async {
      // Arrange

      when(() => mockLocalStorageService.setLanguageCode(any()))
          .thenThrow(testException);

      // Act
      final result = await repository.setLanguage(languageCode);

      // Assert
      expect(result.isLeft, true);
      expect(result.left.title, S.current.set_language_failed);
      verify(() => mockLocalStorageService.setLanguageCode(languageCode))
          .called(1);
    });
  });
}
