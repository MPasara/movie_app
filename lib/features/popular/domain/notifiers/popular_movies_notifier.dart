import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/features/popular/data/models/movie_response.dart';
import 'package:movie_app/features/popular/data/repositories/movie_repository.dart';
import 'package:q_architecture/base_notifier.dart';
import 'package:q_architecture/q_architecture.dart';

final popularMoviesNotifierProvider = StateNotifierProvider<
    PopularMoviesNotifier, BaseState<MovieResponseWrapper>>(
  (ref) => PopularMoviesNotifier(
    ref.read(movieRepositoryProvider),
  )..getPopularMovies(),
);

class PopularMoviesNotifier
    extends StateNotifier<BaseState<MovieResponseWrapper>> {
  final MovieRepository _movieRepository;
  PopularMoviesNotifier(this._movieRepository)
      : super(const BaseState.initial());

  Future<void> getPopularMovies() async {
    state = const BaseState.loading();
    try {
      final eitherFailuerOrMovies = await _movieRepository.getMovies();
      eitherFailuerOrMovies.fold(
        (failure) {
          state = BaseState.error(failure);
        },
        (movies) => state = BaseState.data(movies),
      );
    } catch (e) {
      state = BaseState.error(Failure.generic());
    }
  }
}
