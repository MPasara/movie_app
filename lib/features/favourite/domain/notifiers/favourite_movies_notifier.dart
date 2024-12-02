import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/features/favourite/data/repositories/database_service_impl.dart';
import 'package:movie_app/features/popular/domain/entities/movie.dart';

final favouriteMoviesProvider =
    NotifierProvider<FavouriteMoviesNotifier, Set<int>>(
  FavouriteMoviesNotifier.new,
  name: 'Favourite movies notifier provider',
);

class FavouriteMoviesNotifier extends Notifier<Set<int>> {
  @override
  Set<int> build() {
    loadFavourites();
    return {};
  }

  Future<void> toggleFavourite(Movie movie) async {
    if (state.contains(movie.id)) {
      await ref.read(databaseServiceProvider).unfavouriteMovie(movie.id);
      state = {...state}..remove(movie.id);
    } else {
      await ref.read(databaseServiceProvider).favouriteMovie(movie.id);
      state = {...state}..add(movie.id);
    }
  }

  Future<void> loadFavourites() async {
    final favourites =
        await ref.read(databaseServiceProvider).getFavouriteMovies();
    state = favourites.toSet();
  }
}
