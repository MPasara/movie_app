import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/features/popular/data/repositories/movie_repository.dart';
import 'package:movie_app/features/popular/domain/entities/movie.dart';
import 'package:movie_app/features/popular/domain/providers/current_page_provider.dart';
import 'package:movie_app/generated/l10n.dart';
import 'package:q_architecture/base_notifier.dart';
import 'package:q_architecture/q_architecture.dart';

final popularMoviesNotifierProvider =
    NotifierProvider<PopularMoviesNotifier, BaseState<List<Movie>>>(
  () => PopularMoviesNotifier(),
  name: 'PopularMoviesNotifier',
);

class PopularMoviesNotifier extends Notifier<BaseState<List<Movie>>> {
  List<Movie> movies = [];
  late MovieRepository _movieRepository;
  bool isLoading = false;

  @override
  BaseState<List<Movie>> build() {
    _movieRepository = ref.watch(movieRepositoryProvider);

    getPopularMovies(ref.read(currentPageProvider));

    return const BaseState.initial();
  }

  Future<void> getPopularMovies(int page) async {
    if (isLoading) return;

    isLoading = true;

    if (page == 1) {
      movies.clear();
      state = const BaseState.loading();
    }

    try {
      final eitherFailureOrMovies = await _movieRepository.getMovies(page);

      eitherFailureOrMovies.fold(
        (failure) {
          state = BaseState.error(
            Failure(title: S.current.fetch_movies_failed),
          );
        },
        (newMovies) {
          movies.addAll(newMovies);

          state = BaseState.data(movies);
        },
      );
    } catch (e, st) {
      state = BaseState.error(
        Failure.generic(
          title: S.current.fetch_movies_failed,
          error: e,
          stackTrace: st,
        ),
      );
    } finally {
      isLoading = false;
    }
  }
}
