import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/features/popular/data/repositories/movie_repository.dart';
import 'package:movie_app/features/popular/domain/entities/movie_wrapper.dart';
import 'package:movie_app/generated/l10n.dart';
import 'package:q_architecture/base_notifier.dart';
import 'package:q_architecture/q_architecture.dart';

final popularMoviesNotifierProvider =
    NotifierProvider<PopularMoviesNotifier, BaseState<MovieWrapper>>(
  PopularMoviesNotifier.new,
  name: 'Popular movies notifier',
);

class PopularMoviesNotifier extends Notifier<BaseState<MovieWrapper>> {
  late MovieRepository _movieRepository;

  @override
  BaseState<MovieWrapper> build() {
    _movieRepository = ref.watch(movieRepositoryProvider);

    getPopularMovies(1);

    return const BaseState.initial();
  }

  void loadMoreMovies() {
    final totalPages = switch (state) {
      BaseData(:final data) => data.totalPages,
      _ => 0,
    };
    final currentPage = switch (state) {
      BaseData(:final data) => data.currentPage,
      _ => 0,
    };
    final nextPage = currentPage + 1;

    if (nextPage < totalPages) getPopularMovies(nextPage);
  }

  Future<void> getPopularMovies(int page) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final isLoading = switch (state) {
      BaseData(:final data) => data.isLoading,
      BaseLoading() => true,
      _ => false,
    };

    if (isLoading) return;

    if (page == 1) {
      state = const BaseState.loading();
    } else if (state case BaseData(:final data)) {
      state = BaseData(data.copyWith(isLoading: true));
    }

    final eitherFailureOrMovieWrapper = await _movieRepository.getMovies(page);

    eitherFailureOrMovieWrapper.fold(
      (failure) {
        switch (state) {
          case BaseData():
            break;
          default:
            Fluttertoast.showToast(
              msg: failure.title,
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.redAccent,
              gravity: ToastGravity.SNACKBAR,
              fontSize: 16,
            );
            state = BaseState.error(
              Failure.generic(
                title: S.current.fetch_movies_failed,
                error: failure.error,
                stackTrace: failure.stackTrace,
              ),
            );
        }
      },
      (movieWrapper) {
        state = switch (state) {
          BaseData(:final data) => BaseData(
              data.copyWith(
                currentPage: movieWrapper.currentPage,
                isLoading: false,
                movies: [...data.movies, ...movieWrapper.movies],
              ),
            ),
          _ => BaseState.data(movieWrapper),
        };
      },
    );
  }
}
