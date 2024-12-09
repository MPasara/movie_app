import 'package:either_dart/either.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/features/favourite/data/repositories/database_service.dart';
import 'package:movie_app/features/favourite/data/repositories/database_service_impl.dart';
import 'package:movie_app/features/popular/domain/entities/movie.dart';
import 'package:q_architecture/q_architecture.dart';

final databaseRepositoryProvider = Provider<DatabaseRepository>(
  (ref) => DatabaseRepositoryImpl(
    ref.watch(databaseServiceProvider),
  ),
  name: 'Database Repository Provider',
);

abstract interface class DatabaseRepository {
  EitherFailureOr<void> favouriteMovie(Movie movie);
  EitherFailureOr<void> unfavouriteMovie(Movie movie);
  EitherFailureOr<List<Movie>> loadFavouriteMovies();
}

class DatabaseRepositoryImpl implements DatabaseRepository {
  final DatabaseService _databaseService;

  DatabaseRepositoryImpl(
    DatabaseService databaseService,
  ) : _databaseService = databaseService;

  @override
  EitherFailureOr<List<Movie>> loadFavouriteMovies() async {
    try {
      final favouriteMovies = await _databaseService.getFavouriteMovies();
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
  EitherFailureOr<void> favouriteMovie(Movie movie) async {
    try {
      await _databaseService.favouriteMovie(movie);
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
  EitherFailureOr<void> unfavouriteMovie(Movie movie) async {
    try {
      await _databaseService.unfavouriteMovie(movie);
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
