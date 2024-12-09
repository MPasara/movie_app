import 'package:movie_app/features/popular/domain/entities/movie.dart';

abstract interface class DatabaseService {
  Future<void> initDatabase();
  Future<void> favouriteMovie(Movie movie);
  Future<void> unfavouriteMovie(Movie movie);
  Future<bool> isMovieFavourite(int movieId);
  Future<List<Movie>> getFavouriteMovies();
}
