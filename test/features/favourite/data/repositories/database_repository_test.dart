import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/common/data/two_way_entity_mapper.dart';
import 'package:movie_app/features/favourite/data/repositories/database_repository.dart';
import 'package:movie_app/features/popular/data/models/movie_response.dart';
import 'package:movie_app/features/popular/domain/entities/movie.dart';
import 'package:movie_app/generated/l10n.dart';

import '../../../../test_variables.dart';

void main() {
  late FavouriteMoviesRepositoryImpl repository;
  late MockDatabaseService mockDatabaseService;
  late TwoWayEntityMapper<Movie, MovieResponse> mockMapper;

  setUp(() async {
    await S.load(const Locale.fromSubtags(languageCode: 'en'));

    mockDatabaseService = MockDatabaseService();

    mockMapper = (
      responseMapper: mockResponseMapper.call,
      requestMapper: mockRequestMapper.call,
    );

    repository = FavouriteMoviesRepositoryImpl(
      mockDatabaseService,
      mockMapper,
    );
  });

  group('loadFavouriteMovies', () {
    test('should return Right with list of movies when successful', () async {
      // Arrange
      when(() => mockDatabaseService.getFavouriteMovies())
          .thenAnswer((_) async => [testMovieResponse]);
      when(() => mockMapper.responseMapper(testMovieResponse))
          .thenReturn(testMovie);

      // Act
      final result = await repository.loadFavouriteMovies();

      // Assert
      expect(result.isRight, true);
      expect(result.right, [testMovie]);
      verify(() => mockDatabaseService.getFavouriteMovies()).called(1);
      verify(() => mockMapper.responseMapper(testMovieResponse)).called(1);
    });

    test('should return Left with failure when database service throws',
        () async {
      // Arrange
      when(() => mockDatabaseService.getFavouriteMovies())
          .thenThrow(Exception('Database error'));

      // Act
      final result = await repository.loadFavouriteMovies();

      // Assert
      expect(result.isLeft, true);
      expect(result.left.title, S.current.load_favourite_movies_failed);
      verify(() => mockDatabaseService.getFavouriteMovies()).called(1);
    });
  });

  group('favouriteMovie', () {
    test('should return Right when favouriting is successful', () async {
      // Arrange
      when(() => mockMapper.requestMapper(testMovie))
          .thenReturn(testMovieResponse);
      when(() => mockDatabaseService.favouriteMovie(testMovieResponse))
          .thenAnswer((_) async {
        return;
      });

      // Act
      final result = await repository.favouriteMovie(testMovie);

      // Assert
      expect(result.isRight, true);
      verify(() => mockMapper.requestMapper(testMovie)).called(1);
      verify(() => mockDatabaseService.favouriteMovie(testMovieResponse))
          .called(1);
    });

    test('should return Left with failure when favouriting fails', () async {
      // Arrange
      when(() => mockMapper.requestMapper(testMovie))
          .thenReturn(testMovieResponse);
      when(() => mockDatabaseService.favouriteMovie(testMovieResponse))
          .thenThrow(testException);

      // Act
      final result = await repository.favouriteMovie(testMovie);

      // Assert
      expect(result.isLeft, true);
      expect(result.left.title, S.current.favourite_movies_failed);
      verify(() => mockMapper.requestMapper(testMovie)).called(1);
      verify(() => mockDatabaseService.favouriteMovie(testMovieResponse))
          .called(1);
    });
  });

  group('unfavouriteMovie', () {
    const testMovieId = 1;

    test('should return Right when unfavouriting is successful', () async {
      // Arrange
      when(() => mockDatabaseService.unfavouriteMovie(testMovieId))
          .thenAnswer((_) async {
        return;
      });

      // Act
      final result = await repository.unfavouriteMovie(testMovieId);

      // Assert
      expect(result.isRight, true);
      verify(() => mockDatabaseService.unfavouriteMovie(testMovieId)).called(1);
    });

    test('should return Left with failure when unfavouriting fails', () async {
      // Arrange
      when(() => mockDatabaseService.unfavouriteMovie(testMovieId))
          .thenThrow(testException);

      // Act
      final result = await repository.unfavouriteMovie(testMovieId);

      // Assert
      expect(result.isLeft, true);
      expect(result.left.title, S.current.unfavourite_movies_failed);
      verify(() => mockDatabaseService.unfavouriteMovie(testMovieId)).called(1);
    });
  });
}
