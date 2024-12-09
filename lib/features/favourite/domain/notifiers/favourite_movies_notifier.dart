import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/features/favourite/data/repositories/database_service_impl.dart';
import 'package:movie_app/features/popular/domain/entities/movie.dart';
import 'package:q_architecture/q_architecture.dart';

final favouriteMoviesProvider =
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
          await ref.read(databaseServiceProvider).unfavouriteMovie(movie.id);
          state = {...state}..remove(movie.id);
        } else {
          await ref.read(databaseServiceProvider).favouriteMovie(movie.id);
          state = {...state}..putIfAbsent(movie.id, () => movie);
        }
      },
      duration: const Duration(seconds: 1),
    );
  }

  Future<void> loadFavourites() async {
    final favouriteMovieIds =
        await ref.read(databaseServiceProvider).getFavouriteMovieIds();
    final favouriteMoviesMap = <int, Movie>{};

    for (final id in favouriteMovieIds) {
      /*  final movie = await fetchMovieById(id);
      if (movie != null) {
        favouriteMoviesMap[id] = movie;
      } */
    }
    state = state = favouriteMoviesMap;
  }

  /*  Future<Movie?> fetchMovieById(int id) async {
    // Example logic, adjust according to your TMDB API integration:
    final movieData = await someApiService.getMovieDetails(id);
    return movieData != null
        ? Movie(
            id: movieData['id'],
            title: movieData['title'],
            description: movieData['description'],
            posterImagePath: movieData['poster_path'],
            backdropImagePath: movieData['backdrop_path'],
            voteAverage: movieData['vote_average'].toDouble(),
            genres:
                List<String>.from(movieData['genres'].map((g) => g['name'])),
          )
        : null;
  } */
}

/* class FavoutiteMoviesNotifier2 extends Notifier<BaseState<Set<int>>> {
  late DatabaseService _dbService;

  @override
  BaseState<Set<int>> build() {
    _dbService = ref.watch(databaseServiceProvider);
    return const BaseState.initial();
  }

  Future<void> toggleFavourite(Movie movie) async {
    /*  if (state.contains(movie.id)) {
      await ref.read(databaseServiceProvider).unfavouriteMovie(movie.id);
      state = {...state}..remove(movie.id);
    } else {
      await ref.read(databaseServiceProvider).favouriteMovie(movie.id);
      state = {...state}..add(movie.id);
    } */
  }
} */
