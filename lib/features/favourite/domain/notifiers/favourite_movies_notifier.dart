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
  @override
  Map<int, Movie> prepareForBuild() {
    loadFavourites();
    return {};
  }

  Future<void> toggleFavourite(Movie movie) async {
    throttle(
      () async {
        if (state.containsKey(movie.id)) {
          await ref.read(databaseRepositoryProvider).unfavouriteMovie(movie);
          state = {...state}..remove(movie.id);
        } else {
          await ref.read(databaseRepositoryProvider).favouriteMovie(movie);
          state = {...state}..putIfAbsent(movie.id, () => movie);
        }
      },
      duration: const Duration(milliseconds: 500),
    );
  }

  Future<void> loadFavourites() async {
    final eitherFailureOrFavouriteMovies =
        await ref.read(databaseRepositoryProvider).loadFavouriteMovies();

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
