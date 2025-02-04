import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/common/data/genre_response.dart';
import 'package:movie_app/features/popular/data/repositories/genre_repository.dart';
import 'package:movie_app/generated/l10n.dart';

import '../../../../test_variables.dart';

void main() {
  late GenreRepository repository;
  late MockApiClient mockApiClient;

  setUp(
    () async {
      await S.load(
        const Locale.fromSubtags(languageCode: 'en'),
      );
      mockApiClient = MockApiClient();
      repository = GenreRepositoryImpl(mockApiClient);
    },
  );
  group(
    'getAllGenres',
    () {
      test(
        'should return Right when getAllGenres is successful',
        () async {
          when(
            () => mockApiClient.getAllGenres(),
          ).thenAnswer((_) async {
            return GenreResponseWrapper(
              genres: [
                GenreResponse(id: 1, name: 'testGenre'),
              ],
            );
          });
          final either = await repository.getAllGenres();
          expect(
            either.right,
            kTestGenreResponse,
          );
        },
      );
      test(
        'should return Left when getAllGenres is not successful',
        () async {
          when(
            () => mockApiClient.getAllGenres(),
          ).thenThrow((_) async {
            return testException;
          });
          final either = await repository.getAllGenres();
          expect(
            either.left.title,
            S.current.fetch_genres_failed,
          );
        },
      );
    },
  );
}
