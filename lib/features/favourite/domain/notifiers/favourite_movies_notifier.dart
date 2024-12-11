import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';
import 'package:movie_app/features/favourite/data/repositories/database_repository.dart';
import 'package:movie_app/features/popular/domain/entities/movie.dart';
import 'package:q_architecture/q_architecture.dart';

final favouriteMoviesNotifierProvider =
    NotifierProvider<FavouriteMoviesNotifier, Map<int, Movie>>(
  FavouriteMoviesNotifier.new,
  name: 'Favourite movies notifier provider',
);

class FavouriteMoviesNotifier extends SimpleNotifier<Map<int, Movie>> {
  late FavouriteMoviesRepository _favouriteMoviesRepository;

  @override
  Map<int, Movie> prepareForBuild() {
    _favouriteMoviesRepository = ref.watch(favouriteMoviesRepositoryProvider);
    loadFavourites();
    return {};
  }

  Future<void> toggleFavourite(Movie movie) async {
    throttle(
      () async {
        if (state.containsKey(movie.id)) {
          await _favouriteMoviesRepository.unfavouriteMovie(movie);
          state = {...state}..remove(movie.id);
        } else {
          await _favouriteMoviesRepository.favouriteMovie(movie);
          state = {...state}..putIfAbsent(movie.id, () => movie);
        }
      },
    );
  }

  Future<void> loadFavourites() async {
    final eitherFailureOrFavouriteMovies =
        await _favouriteMoviesRepository.loadFavouriteMovies();

    eitherFailureOrFavouriteMovies.fold(
      (failure) {
        logDebug('Failed to load favourite movies: $failure');
      },
      (favMovies) {
        final favouriteMoviesMap = Map<int, Movie>.fromEntries(
          favMovies.map((movie) => MapEntry(movie.id, movie)),
        );

        state = favouriteMoviesMap;
      },
    );
  }
}
