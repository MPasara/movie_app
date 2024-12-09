import 'package:either_dart/either.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/features/favourite/data/repositories/database_service.dart';
import 'package:movie_app/features/favourite/data/repositories/database_service_impl.dart';
import 'package:movie_app/features/popular/data/repositories/movie_repository.dart';
import 'package:movie_app/features/popular/domain/entities/movie.dart';
import 'package:q_architecture/q_architecture.dart';

final databaseRepositoryProvider = Provider<DatabaseRepository>(
  (ref) => DatabaseRepositoryImpl(
    ref.watch(databaseServiceProvider),
    ref.watch(movieRepositoryProvider),
  ),
  name: 'Database Repository Provider',
);

abstract interface class DatabaseRepository {
  EitherFailureOr<void> favouriteMovie(int movieId);
  EitherFailureOr<void> unfavouriteMovie(int movieId);
  EitherFailureOr<List<Movie>> loadFavouriteMovies();
}

class DatabaseRepositoryImpl implements DatabaseRepository {
  final DatabaseService _databaseService;
  final MovieRepository _movieRepository;

  DatabaseRepositoryImpl(
    DatabaseService databaseService,
    MovieRepository movieRepository,
  )   : _databaseService = databaseService,
        _movieRepository = movieRepository;

  @override
  EitherFailureOr<List<Movie>> loadFavouriteMovies() async {
    try {
      final favouriteMovies = <Movie>[];
      final favouriteMovieIds = await _databaseService.getFavouriteMovieIds();
      final eitherFailureOrPopularMovies = await _movieRepository.getMovies(1);
      return Right(favouriteMovies);
    } catch (e, st) {
      return Left(
        Failure(
          title: 'Load favourite movies failed',
          error: e,
          stackTrace: st,
        ),
      );
    }
  }

  @override
  EitherFailureOr<void> favouriteMovie(int movieId) async {
    try {
      await _databaseService.favouriteMovie(movieId);
      return const Right(null);
    } catch (e, st) {
      return Left(
        Failure(
          title: 'Favourite movie failed',
          error: e,
          stackTrace: st,
        ),
      );
    }
  }

  @override
  EitherFailureOr<void> unfavouriteMovie(int movieId) async {
    try {
      await _databaseService.unfavouriteMovie(movieId);
      return const Right(null);
    } catch (e, st) {
      return Left(
        Failure(
          title: 'Unfavourite movie failed',
          error: e,
          stackTrace: st,
        ),
      );
    }
  }
}
