import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/common/data/repositories/theme_repository.dart';
import 'package:movie_app/common/domain/notifiers/theme_notifier.dart';
import 'package:movie_app/common/domain/providers/failure_provider.dart';
import 'package:movie_app/generated/l10n.dart';

import '../../../test_variables.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(ThemeMode.system);
  });

  late MockThemeRepository mockRepository;
  late ProviderContainer container;

  setUp(() async {
    // Load localization
    await S.load(const Locale.fromSubtags(languageCode: 'en'));

    mockRepository = MockThemeRepository();

    // Setup default success response
    when(() => mockRepository.getThemeMode())
        .thenAnswer((_) async => Right(ThemeMode.dark));

    container = ProviderContainer(
      overrides: [
        themeRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
  });

  group('ThemeNotifier', () {
    test('initial state should be system', () {
      final themeMode = container.read(themeNotifierProvider);
      expect(themeMode, ThemeMode.system);
    });

    group('_initializeTheme', () {
      test('should update state to dark mode when successful', () async {
        final states = <ThemeMode>[];
        container.listen(
          themeNotifierProvider,
          (_, state) => states.add(state),
          fireImmediately: true,
        );

        // Wait for initialization
        await Future.delayed(Duration.zero);

        expect(states, [ThemeMode.system, ThemeMode.dark]);
        verify(() => mockRepository.getThemeMode()).called(1);
      });

      test('should keep system mode and update failure provider when fails',
          () async {
        when(() => mockRepository.getThemeMode())
            .thenAnswer((_) async => Left(testFailure));

        final states = <ThemeMode>[];
        container.listen(
          themeNotifierProvider,
          (_, state) => states.add(state),
          fireImmediately: true,
        );

        // Wait for initialization
        await Future.delayed(Duration.zero);

        expect(states, [ThemeMode.system]); // Should stay as system
        expect(container.read(failureProvider), testFailure);
        verify(() => mockRepository.getThemeMode()).called(1);
      });
    });

    group('setThemeMode', () {
      test('should update state when successful', () async {
        // Create fresh container
        container = ProviderContainer(
          overrides: [
            themeRepositoryProvider.overrideWithValue(mockRepository),
          ],
        );

        when(() => mockRepository.setThemeMode(any()))
            .thenAnswer((_) async => const Right(null));

        final states = <ThemeMode>[];
        container.listen(
          themeNotifierProvider,
          (_, state) => states.add(state),
          fireImmediately: false,
        );
        await Future.delayed(Duration.zero);
        // Act
        await container
            .read(themeNotifierProvider.notifier)
            .setThemeMode(ThemeMode.light);

        expect(states, [ThemeMode.dark, ThemeMode.light]);
        verify(() => mockRepository.setThemeMode(ThemeMode.light)).called(1);
      });

      test('should update state and failure provider when fails', () async {
        container = ProviderContainer(
          overrides: [
            themeRepositoryProvider.overrideWithValue(mockRepository),
          ],
        );

        when(() => mockRepository.setThemeMode(any()))
            .thenAnswer((_) async => Left(testFailure));

        final states = <ThemeMode>[];
        container.listen(
          themeNotifierProvider,
          (_, state) => states.add(state),
          fireImmediately: false,
        );

        await Future.delayed(Duration.zero);
        // Act
        await container
            .read(themeNotifierProvider.notifier)
            .setThemeMode(ThemeMode.light);

        expect(states, [ThemeMode.dark, ThemeMode.light]);
        expect(container.read(failureProvider), testFailure);
        verify(() => mockRepository.setThemeMode(ThemeMode.light)).called(1);
      });
    });
  });
}
