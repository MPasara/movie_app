import 'package:either_dart/either.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/data/api_client.dart';
import 'package:movie_app/common/data/providers.dart';
import 'package:movie_app/common/utils/constants.dart';
import 'package:movie_app/features/popular/data/mappers/movie_entity_mapper.dart';
import 'package:movie_app/features/popular/data/models/movie_response.dart';
import 'package:movie_app/features/popular/data/repositories/genre_repository.dart';
import 'package:movie_app/features/popular/domain/entities/movie.dart';
import 'package:movie_app/features/popular/domain/providers/all_genres_provider.dart';
import 'package:movie_app/generated/l10n.dart';
import 'package:q_architecture/q_architecture.dart';

final movieRepositoryProvider = Provider<MovieRepository>(
  (ref) => MovieRepositoryImpl(
    ref,
    ref.watch(apiClientProvider),
    ref.watch(genreRepositoryProvider),
    ref.watch(
      movieEntityMapperProvider,
    ),
  ),
);

abstract interface class MovieRepository {
  EitherFailureOr<List<Movie>> getMovies();
}

class MovieRepositoryImpl implements MovieRepository {
  final Ref ref;
  final ApiClient _apiClient;
  final GenreRepository _genreRepository;
  final EntityMapper<Movie, MovieResponse> _movieMapper;

  MovieRepositoryImpl(
    this.ref,
    this._apiClient,
    this._genreRepository,
    this._movieMapper,
  );

  @override
  EitherFailureOr<List<Movie>> getMovies() async {
    final allGenres = ref.read(allGenresProvider);
    final movies = <Movie>[];
    try {
      final response = await _apiClient.getMovies(
        kBearerToken,
        kApiLanguage,
        1,
      );
      final movieResponseList = response.results;
      final eitherFailureOrGenres = await _genreRepository.getAllGenres();

      try {
        eitherFailureOrGenres.fold(
          (failure) {
            return Failure(title: failure.title, error: failure.error);
          },
          (genres) {
            for (final genre in genres.genres) {
              allGenres.add(genre);
            }
          },
        );
      } catch (e, st) {
        return Left(
          Failure(
              title: S.current.fethc_genres_failed, error: e, stackTrace: st),
        );
      }

      for (final movieResponse in movieResponseList) {
        final movie = _movieMapper(movieResponse);
        movies.add(movie);
      }

      return Right(movies);
    } catch (e, st) {
      return Left(
        Failure(title: S.current.fethc_movies_failed, error: e, stackTrace: st),
      );
    }
  }
}
