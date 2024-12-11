import 'package:movie_app/features/popular/data/models/movie_response.dart';
import 'package:movie_app/features/popular/domain/entities/movie.dart';

abstract interface class DatabaseService {
  Future<void> initDatabase();
  Future<void> favouriteMovie(MovieResponse movie);
  Future<void> unfavouriteMovie(Movie movie);
  Future<bool> isMovieFavourite(int movieId);
  Future<List<MovieResponse>> getFavouriteMovies();
}
