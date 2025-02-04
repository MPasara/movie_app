import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/common/data/repositories/locale_repository.dart';
import 'package:movie_app/common/domain/notifiers/locale_notifier.dart';
import 'package:movie_app/common/domain/providers/failure_provider.dart';
import 'package:movie_app/common/utils/constants/locale_constants.dart';
import 'package:movie_app/generated/l10n.dart';

import '../../../test_variables.dart';



void main() {
  setUpAll(() {
    registerFallbackValue(const Locale(LocaleConstants.eng));
  });

  late MockLocaleRepository mockRepository;
  late ProviderContainer container;

  setUp(() async {
    // Load localization
    await S.load(const Locale.fromSubtags(languageCode: 'en'));

    mockRepository = MockLocaleRepository();

    // Setup default success response
    when(() => mockRepository.getLanguage())
        .thenAnswer((_) async => const Right(LocaleConstants.eng));

    container = ProviderContainer(
      overrides: [
        localeRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
  });

  group('LocaleNotifier', () {
    test('initial state should be english', () {
      final locale = container.read(localeNotifierProvider);
      expect(locale.languageCode, LocaleConstants.eng);
    });

    group('_initializeLocale', () {
      test('should update state to stored locale when successful', () async {
        final states = <Locale>[];
        container.listen(
          localeNotifierProvider,
          (_, state) => states.add(state),
          fireImmediately: true,
        );

        // Wait for initialization
        await Future.delayed(Duration.zero);

        expect(states, [
          const Locale(LocaleConstants.eng),
          const Locale(LocaleConstants.eng),
        ]);
        verify(() => mockRepository.getLanguage()).called(1);
      });

      test('should keep default locale and update failure provider when fails',
          () async {
        when(() => mockRepository.getLanguage())
            .thenAnswer((_) async => Left(testFailure));

        final states = <Locale>[];
        container.listen(
          localeNotifierProvider,
          (_, state) => states.add(state),
          fireImmediately: true,
        );

        // Wait for initialization
        await Future.delayed(Duration.zero);

        expect(states, [const Locale(LocaleConstants.eng)]);
        expect(container.read(failureProvider), testFailure);
        verify(() => mockRepository.getLanguage()).called(1);
      });
    });

    group('setLocale', () {
      test('should update state and save to repository when successful',
          () async {
        when(() => mockRepository.setLanguage(any()))
            .thenAnswer((_) async => const Right(null));

        final states = <Locale>[];
        container.listen(
          localeNotifierProvider,
          (_, state) => states.add(state),
          fireImmediately: false,
        );

        // Act
        await container
            .read(localeNotifierProvider.notifier)
            .setLocale(const Locale(LocaleConstants.cro));

        expect(states, [
          const Locale(LocaleConstants.cro),
          const Locale(LocaleConstants.eng),
        ]);
        verify(() => mockRepository.setLanguage(LocaleConstants.cro)).called(1);
      });

      test('should update state even when repository fails', () async {
        when(() => mockRepository.setLanguage(any()))
            .thenAnswer((_) async => Left(testFailure));

        final states = <Locale>[];
        container.listen(
          localeNotifierProvider,
          (_, state) => states.add(state),
          fireImmediately: false,
        );

        // Act
        await container
            .read(localeNotifierProvider.notifier)
            .setLocale(const Locale(LocaleConstants.cro));

        expect(states, [
          const Locale(LocaleConstants.cro),
          const Locale(LocaleConstants.eng)
        ]);
        verify(() => mockRepository.setLanguage(LocaleConstants.cro)).called(1);
      });
    });
  });
}
