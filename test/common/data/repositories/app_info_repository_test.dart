import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/common/data/repositories/app_info_repository.dart';
import 'package:movie_app/generated/l10n.dart';

import '../../../test_variables.dart';

void main() {
  late AppInfoRepository repository;
  late MockPackageInfoService mockPackageInfoService;

  setUp(() async {
    await S.load(const Locale.fromSubtags(languageCode: 'en'));

    mockPackageInfoService = MockPackageInfoService();

    repository = AppInfoRepositoryImpl(mockPackageInfoService);
  });

  group('getVersionNumber', () {
    test('should return Right with AppInfo when service call is successful',
        () async {
      // Arrange
      when(() => mockPackageInfoService.getVersionNumber())
          .thenAnswer((_) async => expectedAppInfo);

      // Act
      final result = await repository.getVersionNumber();

      // Assert
      expect(result.isRight, true);
      expect(result.right, expectedAppInfo);
      verify(() => mockPackageInfoService.getVersionNumber()).called(1);
    });

    test('should return Left with failure when service throws exception',
        () async {
      // Arrange
      when(() => mockPackageInfoService.getVersionNumber())
          .thenThrow(testException);

      // Act
      final result = await repository.getVersionNumber();

      // Assert
      expect(result.isLeft, true);
      expect(result.left.title, S.current.fetch_app_version_failed);
      verify(() => mockPackageInfoService.getVersionNumber()).called(1);
    });
  });
}
