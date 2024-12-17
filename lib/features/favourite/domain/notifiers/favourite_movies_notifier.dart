import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/domain/providers/failure_provider.dart';
import 'package:movie_app/common/domain/providers/success_provider.dart';
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
          final eitherFailureOrUnfavourite =
              await _favouriteMoviesRepository.unfavouriteMovie(movie.id);
          eitherFailureOrUnfavourite.fold(
            (failure) => ref.read(failureProvider.notifier).state = failure,
            (_) {
              state = {...state}..remove(movie.id);
            },
          );
        } else {
          final eitherFailureOrFavourite =
              await _favouriteMoviesRepository.favouriteMovie(movie);
          eitherFailureOrFavourite.fold(
            (failure) => ref.read(failureProvider.notifier).state = failure,
            (_) {
              ref.read(successProvider.notifier).state =
                  '${movie.title} added to favourites';
              state = {...state}..putIfAbsent(movie.id, () => movie);
            },
          );
        }
      },
    );
  }

  Future<void> loadFavourites() async {
    final eitherFailureOrFavouriteMovies =
        await _favouriteMoviesRepository.loadFavouriteMovies();

    eitherFailureOrFavouriteMovies.fold(
      (failure) => ref.read(failureProvider.notifier).state = failure,
      (favMovies) {
        final favouriteMoviesMap = Map<int, Movie>.fromEntries(
          favMovies.map((movie) => MapEntry(movie.id, movie)),
        );

        state = favouriteMoviesMap;
      },
    );
  }
}
