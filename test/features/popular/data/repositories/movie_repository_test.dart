import 'dart:ui';

import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/common/utils/constants/constants.dart';
import 'package:movie_app/features/popular/data/repositories/movie_repository.dart';
import 'package:movie_app/features/popular/domain/entities/movie_wrapper.dart';
import 'package:movie_app/features/popular/domain/providers/all_genres_provider.dart';
import 'package:movie_app/generated/l10n.dart';
import 'package:q_architecture/q_architecture.dart';

import '../../../../test_variables.dart';

void main() {
  late MovieRepositoryImpl repository;
  late MockRef mockRef;
  late MockApiClient mockApiClient;
  late MockGenreRepository mockGenreRepository;
  late MockAllGenresProvider mockGenresProvider;

  final testMovieWrapper = MovieWrapper(
    movies: [],
    totalPages: 10,
    currentPage: 1,
  );

  setUp(() async {
    await S.load(const Locale.fromSubtags(languageCode: 'en'));

    mockRef = MockRef();
    mockApiClient = MockApiClient();
    mockGenreRepository = MockGenreRepository();
    mockGenresProvider = MockAllGenresProvider();

    repository = MovieRepositoryImpl(
      mockRef,
      mockApiClient,
      mockGenreRepository,
      (input) => testMovieWrapper, // Direct mapper function
    );
  });

  group('getMovies', () {
    test(
        'should return Right with movie wrapper when all operations are successful',
        () async {
      // Arrange
      when(() => mockRef.read(allGenresProvider.notifier))
          .thenReturn(mockGenresProvider);
      when(() => mockGenresProvider.state).thenReturn({});

      when(
        () => mockApiClient.getMovies(
          kApiLanguage,
          testPage,
        ),
      ).thenAnswer((_) async => testMovieResponseWrapper);

      when(() => mockGenreRepository.getAllGenres()).thenAnswer(
        (_) async => Right(testGenreResponseWrapper),
      );

      // Act
      final result = await repository.getMovies(testPage);

      // Assert
      expect(result.isRight, true);
      expect(result.right, testMovieWrapper);

      // Verify interactions
      verify(
        () => mockApiClient.getMovies(kApiLanguage, testPage),
      ).called(1);
      verify(() => mockGenreRepository.getAllGenres()).called(1);
    });

    test('should return Left with movie fetch failure when API call fails',
        () async {
      // Arrange
      when(() => mockRef.read(allGenresProvider.notifier))
          .thenReturn(mockGenresProvider);
      when(() => mockGenresProvider.state).thenReturn({});

      when(
        () => mockApiClient.getMovies(
          kApiLanguage,
          testPage,
        ),
      ).thenThrow(testException);

      // Act
      final result = await repository.getMovies(testPage);

      // Assert
      expect(result.isLeft, true);
      expect(result.left.title, S.current.fetch_movies_failed);
    });

    test(
        'should return Left with genre fetch failure when genre repository fails',
        () async {
      // Arrange
      when(() => mockRef.read(allGenresProvider.notifier))
          .thenReturn(mockGenresProvider);
      when(() => mockGenresProvider.state).thenReturn({});

      when(
        () => mockApiClient.getMovies(
          kApiLanguage,
          testPage,
        ),
      ).thenAnswer((_) async => testMovieResponseWrapper);

      when(() => mockGenreRepository.getAllGenres()).thenAnswer(
        (_) async => Left(Failure(title: S.current.fetch_genres_failed)),
      );

      // Act
      final result = await repository.getMovies(testPage);

      // Assert
      expect(result.isLeft, true);
      expect(result.left.title, S.current.fetch_genres_failed);
    });

    test('should not fetch genres if already populated', () async {
      // Arrange
      when(() => mockRef.read(allGenresProvider.notifier))
          .thenReturn(mockGenresProvider);
      when(() => mockGenresProvider.state)
          .thenReturn({1: 'Action', 2: 'Drama'});

      when(
        () => mockApiClient.getMovies(
          kApiLanguage,
          testPage,
        ),
      ).thenAnswer((_) async => testMovieResponseWrapper);

      // Act
      final result = await repository.getMovies(testPage);

      // Assert
      expect(result.isRight, true);
      expect(result.right, testMovieWrapper);

      // Verify interactions
      verify(
        () => mockApiClient.getMovies(kApiLanguage, testPage),
      ).called(1);
      verifyNever(() => mockGenreRepository.getAllGenres());
    });
  });
}
