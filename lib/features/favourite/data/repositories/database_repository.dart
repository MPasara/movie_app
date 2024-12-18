import 'package:either_dart/either.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/data/two_way_entity_mapper.dart';
import 'package:movie_app/features/favourite/data/repositories/database_service.dart';
import 'package:movie_app/features/favourite/data/repositories/database_service_impl.dart';
import 'package:movie_app/features/popular/data/mappers/movie_entity_mapper.dart';
import 'package:movie_app/features/popular/data/models/movie_response.dart';
import 'package:movie_app/features/popular/domain/entities/movie.dart';
import 'package:q_architecture/q_architecture.dart';

final favouriteMoviesRepositoryProvider = Provider<FavouriteMoviesRepository>(
  (ref) => FavouriteMoviesRepositoryImpl(
    ref.watch(databaseServiceProvider),
    ref.watch(
      twoWayMovieEntityMapperProvider,
    ),
  ),
  name: 'Database Repository Provider',
);

abstract interface class FavouriteMoviesRepository {
  EitherFailureOr<void> favouriteMovie(Movie movie);
  EitherFailureOr<void> unfavouriteMovie(int movieId);
  EitherFailureOr<List<Movie>> loadFavouriteMovies();
}

class FavouriteMoviesRepositoryImpl implements FavouriteMoviesRepository {
  FavouriteMoviesRepositoryImpl(
    DatabaseService databaseService,
    TwoWayEntityMapper<Movie, MovieResponse> twoWayEntityMapper,
  )   : _databaseService = databaseService,
        _twoWayEntityMapper = twoWayEntityMapper;

  final DatabaseService _databaseService;
  final TwoWayEntityMapper<Movie, MovieResponse> _twoWayEntityMapper;

  @override
  EitherFailureOr<List<Movie>> loadFavouriteMovies() async {
    final favourites = <Movie>[];
    try {
      final favouriteMovies = await _databaseService.getFavouriteMovies();
      for (final movieResponse in favouriteMovies) {
        final movie = _twoWayEntityMapper.responseMapper(movieResponse);
        favourites.add(movie);
      }
      return Right(favourites);
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
      final movieResponse = _twoWayEntityMapper.requestMapper(movie);
      await _databaseService.favouriteMovie(movieResponse);
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
