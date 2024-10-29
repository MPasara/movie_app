import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/features/popular/data/repositories/movie_repository.dart';
import 'package:movie_app/features/popular/domain/entities/movie.dart';
import 'package:movie_app/generated/l10n.dart';
import 'package:q_architecture/base_notifier.dart';
import 'package:q_architecture/q_architecture.dart';

final popularMoviesNotifierProvider =
    StateNotifierProvider<PopularMoviesNotifier, BaseState<List<Movie>>>(
  (ref) => PopularMoviesNotifier(
    ref.watch(movieRepositoryProvider),
  )..getPopularMovies(),
);

class PopularMoviesNotifier extends StateNotifier<BaseState<List<Movie>>> {
  final MovieRepository _movieRepository;
  PopularMoviesNotifier(this._movieRepository)
      : super(const BaseState.initial());

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
