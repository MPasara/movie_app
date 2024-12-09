abstract interface class DatabaseService {
  Future<void> initDatabase();
  Future<void> favouriteMovie(int movieId);
  Future<void> unfavouriteMovie(int movieId);
  Future<bool> isMovieFavourite(int movieId);
  Future<List<int>> getFavouriteMovieIds();
}
