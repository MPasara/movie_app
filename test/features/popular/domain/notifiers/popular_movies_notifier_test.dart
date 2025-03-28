import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/features/popular/data/repositories/movie_repository.dart';
import 'package:movie_app/features/popular/domain/entities/movie_wrapper.dart';
import 'package:movie_app/features/popular/domain/notifiers/popular_movies_notifier.dart';
import 'package:movie_app/generated/l10n.dart';
import 'package:q_architecture/base_notifier.dart';
import 'package:q_architecture/q_architecture.dart';

import '../../../../test_variables.dart';

void main() {
  late MockMovieRepository mockRepository;
  late ProviderContainer container;

  setUp(() async {
    // Load localization
    await S.load(const Locale.fromSubtags(languageCode: 'en'));

    mockRepository = MockMovieRepository();

    // Setup default success response for first page
    when(() => mockRepository.getMovies(1))
        .thenAnswer((_) async => Right(testMovieWrapper));

    container = ProviderContainer(
      overrides: [
        movieRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
  });

  group('PopularMoviesNotifier', () {
    test('initial state should be Initial and trigger first page load',
        () async {
      final states = <BaseState<MovieWrapper>>[];
      container.listen(
        popularMoviesNotifierProvider,
        (_, state) => states.add(state),
        fireImmediately: true,
      );

      // Wait for initial load
      await Future.delayed(const Duration(milliseconds: 200));

      expect(
        states,
        [
          const BaseInitial<MovieWrapper>(),
          const BaseLoading<MovieWrapper>(),
          BaseData<MovieWrapper>(testMovieWrapper),
        ],
      );
      verify(() => mockRepository.getMovies(1)).called(1);
    });

    group('loadMoreMovies', () {
      test('should not load more when already loading', () async {
        // Setup state with loading flag
        container.read(popularMoviesNotifierProvider.notifier).state =
            BaseData(testMovieWrapper.copyWith(isLoading: true));

        // Act
        container.read(popularMoviesNotifierProvider.notifier).loadMoreMovies();
        await Future.delayed(const Duration(milliseconds: 200));

        // Assert - should not make additional calls
        verifyNever(() => mockRepository.getMovies(any()));
      });

      test('should not load more when at last page', () async {
        // Clear any previous mock calls
        clearInteractions(mockRepository);

        // Setup state at last page
        container.read(popularMoviesNotifierProvider.notifier).state = BaseData(
          testMovieWrapper.copyWith(currentPage: 3, totalPages: 3),
        );

        // Act
        container.read(popularMoviesNotifierProvider.notifier).loadMoreMovies();
        await Future.delayed(const Duration(milliseconds: 200));

        // Assert
        verify(() => mockRepository.getMovies(any())).called(1);
      });
    });

    group('getPopularMovies', () {
      test('should show loading state and update with new data for first page',
          () async {
        final states = <BaseState<MovieWrapper>>[];
        container.listen(
          popularMoviesNotifierProvider,
          (_, state) => states.add(state),
          fireImmediately: false,
        );

        // Act
        await container
            .read(popularMoviesNotifierProvider.notifier)
            .getPopularMovies(1);
        await Future.delayed(const Duration(milliseconds: 200));

        // Assert
        expect(
          states,
          [
            const BaseLoading<MovieWrapper>(),
            BaseData<MovieWrapper>(testMovieWrapper),
          ],
        );
        verify(() => mockRepository.getMovies(1)).called(1);
      });

      test('should show loading state and update failure provider when fails',
          () async {
        final customNotifier = PopularMoviesNotifier()..autoInitialize = false;

        container = ProviderContainer(
          overrides: [
            movieRepositoryProvider.overrideWithValue(mockRepository),
            popularMoviesNotifierProvider.overrideWith(() => customNotifier),
          ],
        );

        when(() => mockRepository.getMovies(any())).thenAnswer(
          (_) async => Left(Failure(title: S.current.fetch_movies_failed)),
        );

        final states = <BaseState<MovieWrapper>>[];
        container.listen(
          popularMoviesNotifierProvider,
          (_, state) => states.add(state),
          fireImmediately: false,
        );

        // Act
        await container
            .read(popularMoviesNotifierProvider.notifier)
            .getPopularMovies(1);

        await Future.delayed(const Duration(milliseconds: 150));

        // Assert
        expect(
          states,
          [
            const BaseLoading<MovieWrapper>(),
            BaseError<MovieWrapper>(
              Failure(title: S.current.fetch_movies_failed),
            ),
          ],
        );

        verify(() => mockRepository.getMovies(1)).called(1);
      });
    });
  });
}
