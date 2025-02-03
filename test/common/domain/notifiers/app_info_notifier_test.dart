import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/common/data/repositories/app_info_repository.dart';
import 'package:movie_app/common/domain/entities/app_info.dart';
import 'package:movie_app/common/domain/notifiers/app_info_notifier.dart';
import 'package:movie_app/generated/l10n.dart';
import 'package:q_architecture/base_notifier.dart';
import 'package:q_architecture/q_architecture.dart';

import '../../../test_variables.dart';

class MockAppInfoRepository extends Mock implements AppInfoRepository {}


void main() {
  late MockAppInfoRepository mockRepository;
  late ProviderContainer container;

  setUp(() async {
    // Load localization
    await S.load(const Locale.fromSubtags(languageCode: 'en'));

    // Initialize mocks
    mockRepository = MockAppInfoRepository();

    // Corrected method name
    when(() => mockRepository.getVersionNumber())
        .thenAnswer((_) async => Right(expectedAppInfo));

    // Setup notifier with mocks
    container = ProviderContainer(
      overrides: [
        appInfoRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
  });

  group(
    'AppInfoNotifier',
    () {
      test('initial state should be Initial', () {
        final freshNotifier = container.read(appInfoNotifierProvider.notifier);
        expect(freshNotifier.state, const BaseState<Never>.initial());
      });

      group('getAppInfo', () {
        test('should update state to BaseData when successful', () async {
          // Act

          final states = <BaseState<AppInfo>>[];
          container.listen(
            appInfoNotifierProvider,
            (_, state) => states.add(state),
            fireImmediately: false,
          );
          await 500.milliseconds;
          // Assert

          expect(
            states,
            [BaseLoading<Never>(), BaseData(expectedAppInfo)],
          );
          verify(() => mockRepository.getVersionNumber()).called(1);
        });

        test('should update state to BaseError when repository throws',
            () async {
          when(() => mockRepository.getVersionNumber())
              .thenAnswer((_) async => Left(testFailure));
          final states = <BaseState<AppInfo>>[];
          container.listen(
            appInfoNotifierProvider,
            (_, state) => states.add(state),
            fireImmediately: false,
          );
          await 500.milliseconds;
          // Assert

          expect(
            states,
            [BaseLoading<Never>(), BaseError<AppInfo>(testFailure)],
          );
          verify(() => mockRepository.getVersionNumber()).called(1);
        });
      });
    },
  );
}
