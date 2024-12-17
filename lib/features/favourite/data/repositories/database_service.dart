import 'package:movie_app/features/popular/data/models/movie_response.dart';

abstract interface class DatabaseService {
  Future<void> initDatabase();
  Future<void> favouriteMovie(MovieResponse movie);
  Future<void> unfavouriteMovie(int movieId);
  Future<bool> isMovieFavourite(int movieId);
  Future<List<MovieResponse>> getFavouriteMovies();
}
