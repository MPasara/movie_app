import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/features/popular/data/repositories/movie_repository.dart';
import 'package:movie_app/features/popular/domain/entities/movie.dart';
import 'package:movie_app/generated/l10n.dart';
import 'package:q_architecture/base_notifier.dart';
import 'package:q_architecture/q_architecture.dart';

final popularMoviesNotifierProvider =
    NotifierProvider<PopularMoviesNotifier, BaseState<List<Movie>>>(
  () => PopularMoviesNotifier(),
);

class PopularMoviesNotifier extends Notifier<BaseState<List<Movie>>> {
  late MovieRepository _movieRepository;

  @override
  BaseState<List<Movie>> build() {
    _movieRepository = ref.watch(movieRepositoryProvider);
    getPopularMovies();
    return const BaseState.initial();
  }

  Future<void> getPopularMovies() async {
    state = const BaseState.loading();
    try {
      final eitherFailuerOrMovies = await _movieRepository.getMovies();

      eitherFailuerOrMovies.fold(
        (failure) {
          state = BaseState.error(
            Failure(title: S.current.fethc_movies_failed),
          );
        },
        (movies) => state = BaseState.data(movies),
      );
    } catch (e) {
      state = BaseState.error(Failure.generic());
    }
  }
}
